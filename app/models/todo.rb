class Todo < ApplicationRecord
  include AASM

  aasm do
    state :ready, initial: true
    state :not_ready

    event :first do
      transitions from: :ready, to: :not_ready
    end

    event :second do
      transitions from: :not_ready, to: :ready
    end
  end
end
