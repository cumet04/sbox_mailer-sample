class Permission
  AD = 'ad'
  NOTIFY = 'notify'

  def initialize(can_ad, can_notify)
    @can_ad = can_ad # bool
    @can_notify = can_notify # bool
  end

  def can?(type)
    {
      AD => @can_ad,
      NOTIFY => @can_notify
    }[type] || false
  end
end
