class ApplicationController < ActionController::Base

  # protect_from_forgery

  # given an AR model class and hash of params returns another hash containing
  # only the "mass assignable" params
  def filter_params model_class, params
    params.dup.extract! *model_class.accessible_attributes.to_a[1..-1]
  end

  # given some data or a status code and some data, peforms the rails response
  # dance sending the data as json
  def respond code_or_data, data = nil
    # allow respond(data)
    return respond 200, code_or_data unless is_response_code? code_or_data
    render :json => data, :status => code_or_data
  end

  def is_response_code? obj
    obj.kind_of?(Integer) or obj.kind_of?(Symbol)
  end

end
