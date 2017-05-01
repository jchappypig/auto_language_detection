require 'linguist'

$db = {}
Dir.entries('./samples').drop(2).each do |language_folder|
  samples_path = "./samples/#{language_folder}"
  language_files = Dir["#{samples_path}/*"]
  language_files.each do |language_file|
    language = Linguist::Language[language_folder]
    if language && language.codemirror_mode
      if File.directory?(language_file)
        language_sub_files = Dir["#{language_file}/*"]
        language_sub_files.each do |language_file|
          data = File.read(language_file)
          Linguist::Classifier.train!($db, language_folder, data)
        end
      else
        data = File.read(language_file)
        Linguist::Classifier.train!($db, language_folder, data)
      end
    end
  end
end
