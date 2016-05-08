task :default

desc "Compile pl0.pegjs browser version"
task :web do
  sh "pegjs -e pl0 model/pl0.pegjs public/js/pl0.js"
end

desc "Remove pl0.pegjs"
task :clean do
  sh "rm -f public/js/pl0.js"
end
