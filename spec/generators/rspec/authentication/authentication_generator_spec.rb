# Generators are not automatically loaded by Rails
require 'generators/rspec/authentication/authentication_generator'
require 'support/generators'

RSpec.describe Rspec::Generators::AuthenticationGenerator, type: :generator do
  setup_default_destination

  it 'runs both the model and fixture tasks' do
    gen = generator
    expect(gen).to receive :create_user_spec
    expect(gen).to receive :create_fixture_file
    gen.invoke_all
  end

  describe 'the generated files' do
    it 'creates the user spec' do
      run_generator

      expect(File.exist?(file('spec/models/user_spec.rb'))).to be true
    end

    describe 'with fixture replacement' do
      before do
        run_generator ['--fixture-replacement=factory_bot']
      end

      describe 'the fixtures' do
        it "will skip the file" do
          expect(File.exist?(file('spec/fixtures/users.yml'))).to be false
        end
      end
    end
  end
end
