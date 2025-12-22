RSpec.describe Domain::Environment do
  describe '変数の管理' do
    let(:root_env) { Domain::Environment.new }

    it '値を定義して取得できること' do
      root_env.define(:x, 100)
      expect(root_env.get(:x)).to eq(100)
    end

    it '親環境の値を参照できること' do
      root_env.define(:g, 1)
      child_env = Domain::Environment.new(root_env)
      expect(child_env.get(:g)).to eq(1)
    end

    it '子環境の定義が親に影響しないこと(シャドウイング)' do
      root_env.define(:v, 'global')
      child_env = Domain::Environment.new(root_env)
      child_env.define(:v, 'local')

      expect(root_env.get(:v)).to eq('global')
      expect(child_env.get(:v)).to eq('local')
    end

    it '定義されていない変数を参照するとエラーになること' do
      expect { root_env.get(:y) }.to raise_error(StandardError, /Unbound variable/)
    end
  end
end
