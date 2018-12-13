%w[example@e.com example1@e.com].each do |email|
  user = User.create!(email: email, password: 'qwertyQ2')
  prj1 = Project.create!(name: 'Project1', user: user)
  prj2 = Project.create!(name: 'Project2', user: user)

  task1 = Task.create!(name: 'Task1', project: prj1)
  Task.create!(name: 'Task2', project: prj1)
  Task.create!(name: 'Task3', project: prj1)
  Task.create!(name: 'Task4', project: prj1)
  task5 = Task.create!(name: 'Task5', project: prj1)
  Task.create!(name: 'Task6', project: prj2)
  Task.create!(name: 'Task7', project: prj2)
  Task.create!(name: 'Task8', project: prj2)
  Task.create!(name: 'Task9', project: prj2)
  Task.create!(name: 'Task10', project: prj2)

  Comment.create!(body: 'Comment1', task: task1)
  Comment.create!(body: 'Comment5', task: task5)
end
