# Ninety Nine cats
Clones the (now defunct) dress rental website 99dresses

## Features
- uses Ruby DateTime and Date to display the cat's birthday
- validates that no two APPROVED cat requests for the same cat can overlap in time:
  `#overlapping_requests` and  `#overlapping_approved_requests` by using the logic:
  if there exists interval A and B and A(s) denotes the start time and A(e) denotes the
  end time, we can obtain all overlapping requests by !(A(e) <= B(s) && (B(e) <= A(s)))
- order the requests on the cat show page using `order`
- Uses `letter_opener` to open welcome email in development mode upon sign up
- uses helpers to DRY authentication and method input for forms
