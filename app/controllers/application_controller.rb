class ApplicationController < ActionController::Base

  # protect_from_forgery

  # given an AR model class and hash of params returns another hash containing
  # only the "mass assignable" params
  def filter_params model_class, params
    params.dup.extract! *model_class.accessible_attributes.to_a[1..-1]
  end

  # given some data or a status code and some data, peforms the rails response
  # dance sending the data as json
  def respond code, data = nil
    # allow respond(data)
    return respond 200, code unless code.kind_of?(Integer) or code.kind_of?(Symbol)
    render :json => data, :status => code
  end


end
