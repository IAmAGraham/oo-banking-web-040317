class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    if sender.valid? && receiver.valid?
      true
    else
      false
    end
  end

  def execute_transaction
    @current_amount = @amount
    if sender.balance >= @amount
      sender.balance -= @amount
    else
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
    receiver.balance += @amount
    @status = "complete"
    @amount = 0
  end

  def reverse_transfer
    if @status == "complete"
      receiver.balance -= @current_amount
      sender.balance += @current_amount
      @status = "reversed"
    end
  end

end
