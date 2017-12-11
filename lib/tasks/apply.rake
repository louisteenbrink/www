namespace :apply do
  task create: :environment do
    apply_params = {
      first_name: 'Sébastien',
      last_name: 'Saunier',
      email: "seb@lewagon.org",
      phone: "+33600000000",
      age: 30 + rand(10),
      motivation: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi quas assumenda ea deleniti sint necessitatibus quibusdam omnis optio molestiae non ratione laudantium dignissimos repudiandae praesentium reiciendis, qui ipsum blanditiis fugit!",
      source: "Testing from rake",
    }

    apply = Apply.new(apply_params)
    card = PushToTrelloRunner.new(apply).run
    PushStudentToCrmRunner.new(card, apply).run

    puts "Created card for #{apply.email}"
  end

  task send_all_to_kitt: :environment do
    puts "=== Sending #{Apply.count} appications ==="
    i = 1
    t = Apply.count / 1000
    Apply.find_in_batches do |applies|
      puts "#{i} / #{t}"
      applies.each do |apply|
        PushApplyToKittRunner.new(apply).run
      end
      i += 1
    end
    puts '=== Done! ==='
  end
end
