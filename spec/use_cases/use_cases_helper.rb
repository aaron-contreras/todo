# frozen_string_literal: true

Dir[Dir.pwd + '/app/use_cases//**/*.rb'].each {|file| require file }
