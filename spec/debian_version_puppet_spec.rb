require "debian_version_puppet"

describe DebianVersionPuppet::Version do
  context "when creating new version" do
    it "is parsing basic version" do
      v = DebianVersionPuppet::Version.parse('1:20191210.1-0ubuntu0.19.04.2')
      expect(v.epoch).to eql(1)
      expect(v.upstream_version).to eql('20191210.1')
      expect(v.debian_revision).to eql('0ubuntu0.19.04.2')
    end

    it "is parsing no epoch basic version" do
      v = DebianVersionPuppet::Version.parse('20191210.1-0ubuntu0.19.04.2')
      expect(v.epoch).to eql(0)
      expect(v.upstream_version).to eql('20191210.1')
      expect(v.debian_revision).to eql('0ubuntu0.19.04.2')
    end

    it "is parsing no debian revision basic version" do
      v = DebianVersionPuppet::Version.parse('2.42.1+19.04')
      expect(v.epoch).to eql(0)
      expect(v.upstream_version).to eql('2.42.1+19.04')
      expect(v.debian_revision).to eql(nil)
    end

    it "is parsing no epoch complex version" do
      v = DebianVersionPuppet::Version.parse('3.32.2+git20190711-2ubuntu1~19.04.1')
      expect(v.epoch).to eql(0)
      expect(v.upstream_version).to eql('3.32.2+git20190711')
      expect(v.debian_revision).to eql('2ubuntu1~19.04.1')
    end

    it "is parsing even more complex version" do
      v = DebianVersionPuppet::Version.parse('5:1.0.0+git-20190109.133f4c4-0ubuntu2')
      expect(v.epoch).to eql(5)
      expect(v.upstream_version).to eql('1.0.0+git-20190109.133f4c4')
      expect(v.debian_revision).to eql('0ubuntu2')
    end
  end
  context "when comparing two versions" do
    it "epoch has precedence" do
      first = DebianVersionPuppet::Version.parse('9:99-99')
      second = DebianVersionPuppet::Version.parse('10:01-01')
      expect(first < second).to eql(true)
    end
    it "handles equals letters-only versions" do
      lower = DebianVersionPuppet::Version.parse('abd-def')
      higher = DebianVersionPuppet::Version.parse('abd-def')
      expect(lower == higher).to eql(true)
    end
    it "shorter version is smaller" do
      lower = DebianVersionPuppet::Version.parse('abd-de')
      higher = DebianVersionPuppet::Version.parse('abd-def')
      expect(lower < higher).to eql(true)
    end
    it "shorter version is smaller even with digits" do
      lower = DebianVersionPuppet::Version.parse('a1b2d-d3e')
      higher = DebianVersionPuppet::Version.parse('a1b2d-d3ef')
      expect(lower < higher).to eql(true)
    end
    it "shorter version is smaller when number is less" do
      lower = DebianVersionPuppet::Version.parse('a1b2d-d9')
      higher = DebianVersionPuppet::Version.parse('a1b2d-d13')
      expect(lower < higher).to eql(true)
    end
    it "handles ~ version" do
      lower = DebianVersionPuppet::Version.parse('a1b2d-d10~')
      higher = DebianVersionPuppet::Version.parse('a1b2d-d10')
      expect(lower < higher).to eql(true)
    end
    it "handles letters versus -" do
      lower = DebianVersionPuppet::Version.parse('a1b2d-d1a')
      higher = DebianVersionPuppet::Version.parse('a1b2d-d1-')
      expect(lower < higher).to eql(true)
    end
  end
end
