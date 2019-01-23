require 'rspec'
require 'json'
require 'bosh/template/test'

describe 'dockersh job' do
  let(:release) { Bosh::Template::Test::ReleaseDir.new(File.join(File.dirname(__FILE__), '../..')) }
  let(:job) { release.job('dockersh') }

  describe 'env' do
    let(:template) { job.template('bin/dockersh') }

    it 'renders environment variables' do
      file = template.render("env" => { "FOO" => "BAR", "BAR" => "FOO" })
      expect(file).to include("BAR=$'FOO'")
    end

    it 'escapes newlines in environment variables' do
      file = template.render("env" => { "FOO_CA" => "-- BEGIN CERT --\nBAR\n-- END CERT --" })
      expect(file).to include("FOO_CA=$'-- BEGIN CERT --\\nBAR\\n-- END CERT --'")
    end
  end
end
