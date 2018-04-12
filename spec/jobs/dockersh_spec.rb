require 'rspec'
require 'json'
require 'bosh/template/test'

describe 'dockersh job' do
  let(:release) { Bosh::Template::Test::ReleaseDir.new(File.join(File.dirname(__FILE__), '../..')) }
  let(:job) { release.job('dockersh') }

  describe 'env' do
    let(:template) { job.template('config/env') }

    it 'renders environment variables' do
      env = template.render("env" => { "FOO" => "BAR", "BAR" => "FOO" }).split("\n")
      expect(env[0]).to eq('FOO=BAR')
      expect(env[1]).to eq('BAR=FOO')
    end

    it 'renders empty file when no environment variables given' do
      env = template.render({})
      expect(env).to eq("\n")
    end
  end
end
