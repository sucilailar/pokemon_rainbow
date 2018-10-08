def assert_gt(a, b)
    assert_operator a, :>, b
  end

  def assert_gte(a, b)
    assert_operator a, :>=, b
  end

  def assert_lt(a, b)
    assert_operator a, :<, b
  end

  def assert_lte(a, b)
    assert_operator a, :<=, b
  end