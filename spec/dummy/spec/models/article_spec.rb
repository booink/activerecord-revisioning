require 'rails_helper'

require 'active_record'

RSpec.describe Article, type: :model do
  #before do
  #  version = '20180902000000'
  #  puts "version: #{version}"
  #  ActiveRecord::MigrationContext.new(Migrator.migrations_paths).up(version)
  #  puts "after migration"
  #end
  describe '.revisioning' do
    subject { Article.respond_to?(:revisioning) }
    it 'respond to revisioning' do
      is_expected.to be_truthy
    end
  end

  describe '#revisions' do
    let (:article) { Article.create }
    it 'respond to revisions' do
      expect(article.respond_to?(:revisions)).to be_truthy
    end

    it 'revisions class' do
      expect(article.revisions.klass).to eq(ArticleRevision)
    end
  end
end
