#require "mocha-on-bacon"
require 'torquebox-core'
require 'torquespec'
require 'pry'


#module BaconExtensions
    #def let(name,&block)
       #BaconExtensions.module_eval do
           #define_method(name) do 
              #@_memoized ||= {}
              #@_memoized.fetch(name) { |k| @_memoized[k] = instance_eval(&block) }
           #end
       #end
    #end
#end

#class Bacon::Context
    #include BaconExtensions
#end
