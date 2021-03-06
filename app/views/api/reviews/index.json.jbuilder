@reviews.each do |review|
  json.set! review.id do
    json.partial! "/api/reviews/review", review: review
    json.reviewer review.reviewer.first_name
  end
end
