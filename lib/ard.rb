# Active Record Data
module ARD

  extend self

  # given an AR object or array of AR objects, return the attributes
  def attrs(obj)
    if obj.respond_to?(:map)
      records_attrs obj
    else
      record_attrs obj
    end
  end

  # given an AR object, return the errors and attributes
  # (both as hashes)
  def attrs_and_errs(record)
    errors  = record.errors.to_hash
    attribs = record.attributes
    [attribs, errors]
  end

  # ---

  def records_attrs ar_records
    ar_records.map &method(:record_attrs)
  end

  def record_attrs ar_record
    ar_record.try(:attributes)
  end

end
