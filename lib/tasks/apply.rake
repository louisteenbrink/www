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

  task send_london_to_kitt: :environment do
    Apply.where(batch_id: [38, 49, 77, 67, 131, 107, 88]).each do |apply|
      PushApplyToKittRunner.new(apply).run
      puts '=== Sent! ==='
    end
  end
end
