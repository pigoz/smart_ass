class SmartAss::YCbCrTVColorMatrix < SmartAss::YCbCrColorMatrix
  def y_minmax
    [16.0, 235.0]
  end

  def cbcr_minmax
    [16.0, 240.0]
  end

  def excursion_vector
    [219.0, 224.0, 224.0]
  end

  def offset_vector
    Matrix.column_vector([16.0, 128.0, 128.0])
  end
end

class SmartAss::YCbCrFULLColorMatrix < SmartAss::YCbCrColorMatrix
  def y_minmax
    [16.0, 235.0]
  end

  def cbcr_minmax
    [16.0, 240.0]
  end

  def excursion_vector
    [219.0, 224.0, 224.0]
  end

  def offset_vector
    Matrix.column_vector([16.0, 128.0, 128.0])
  end
end
