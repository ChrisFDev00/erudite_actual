# == Schema Information
#
# Table name: notebooks
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  notebookable_type :string           not null
#  notebookable_id   :integer          not null
#  user_id           :integer          not null
#  title             :string
#
# Indexes
#
#  index_notebooks_on_notebookable  (notebookable_type,notebookable_id)
#  index_notebooks_on_user_id       (user_id)
#

class Notebook < ApplicationRecord
  belongs_to :notebookable, polymorphic: true
  belongs_to :user

  has_rich_text :content
end
