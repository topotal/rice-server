namespace :ridgepole do
  %i!export dry-run apply!.each do |task_name|
    desc 'ridgepole --export to db/schema/Schemafile' if task_name == :export
    desc 'ridgepole --dry-run' if task_name == :"dry-run"
    desc 'ridgepole apply' if task_name == :apply
    task task_name do
      args = %w(ridgepole --config config/database.yml)
      args << '--env' << Rails.env
      args << '--export' << '--split' << '--output' << 'db/schema/Schemafile' if task_name == :export
      args << '--dry-run' if task_name == :'dry-run'
      args << '--apply' << '--file' << 'db/schema/Schemafile' if task_name != :export
      p args.join(' ')
      system(*args)
    end
  end
end
