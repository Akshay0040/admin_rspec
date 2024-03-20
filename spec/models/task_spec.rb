# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with valid attributes" do
    task = Task.new(title: "Example Task", description: "This is an example task.")
    expect(task).to be_valid
  end

  it "is not valid without a title" do
    task = Task.new(title: nil, description: "This is an example task.")
    expect(task).to_not be_valid
  end

  it "is not valid without a description" do
    task = Task.new(title: "Example Task", description: nil)
    expect(task).to_not be_valid
  end
end

