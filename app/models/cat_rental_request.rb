class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(APPROVED DENIED PENDING)

  after_initialize :set_status
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: STATUSES, message: "Invalid Status" }
  validate  :approved_request_cannot_overlap_with_any_approved_request
  validate  :start_date_is_before_end_date

  belongs_to :cat, dependent: :destroy

  def approve!
    raise "not pending" unless self.status == "PENDING"
    transaction do
      self.update(status: "APPROVED")
      overlapping_pending_requests.update_all(status: 'DENIED' )
    end
  end

  def approved?
    self.status == "APPROVED"
  end

  def denied?
    self.status == "DENIED"
  end

  def deny!
    self.update(status: "DENIED")
  end

  def pending?
    self.status == "PENDING"
  end

  private
  def set_status
    self.status ||= "PENDING"
  end

  def overlapping_requests
    CatRentalRequest
        .where.not(id: self.id)
        .where(cat_id: cat_id)
        .where(<<-SQL, start_date: start_date, end_date: end_date)
            NOT((start_date > :end_date) OR (end_date < :start_date))
        SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def approved_request_cannot_overlap_with_any_approved_request
    return if self.denied?

    unless overlapping_approved_requests.empty?
      errors[:dates] << "cannot overlap with existing approved requests"
    end
  end

  def start_date_is_before_end_date
    if end_date < start_date
      errors[:start_date] << "cannot be after end date"
      errors[:end_date] << "cannot be before start date"
    end
  end

  def greedy_interval_scheduling
  
  end


end
