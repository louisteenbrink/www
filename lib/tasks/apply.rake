namespace :apply do
  task create: :environment do
    apply_params = {
      first_name: 'Sébastien',
      last_name: 'Saunier',
      email: 'seb@lewagon.org',
      phone: '+33600000000',
      age: 30 + rand(10),
      motivation: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi quas assumenda ea deleniti sint necessitatibus quibusdam omnis optio molestiae non ratione laudantium dignissimos repudiandae praesentium reiciendis, qui ipsum blanditiis fugit!',
      source: 'Testing from rake'
    }

    apply = Apply.new(apply_params)
    card = PushToTrelloRunner.new(apply).run
    PushStudentToCrmRunner.new(card, apply).run

    puts "Created card for #{apply.email}"
  end

  task send_all_to_kitt: :environment do
    puts "=== Sending #{Apply.count} appications ==="
    i = 1
    t = (Apply.count / 1000) + 1
    Apply.find_in_batches do |applies|
      puts "#{i} / #{t}"
      applies.each do |apply|
        PushApplyToKittRunner.new(apply).run
      end
      i += 1
    end
    puts '=== Done! ==='
  end

  task migrate: :environment do
    kitt_camps = [{ 'london' => { id: 9, camps: [90, 192, 77, 130, 111, 72, 172, 202, 149] } }, { 'recife' => { id: 29, camps: [194] } }, { 'beirut' => { id: 16, camps: [48, 15] } }, { 'brussels' => { id: 18, camps: [33, 81, 143, 190, 187, 214, 10, 45, 7, 18, 13, 110] } }, { 'lille' => { id: 17, camps: [167, 42, 200, 92, 107, 123, 71, 75, 14, 32, 155, 157] } }, { 'copenhagen' => { id: 10, camps: [152, 169, 91, 108, 197, 198, 49, 78] } }, { 'chengdu' => { id: 22, camps: [189, 125, 162] } }, { 'florianopolis' => { id: 23, camps: [] } }, { 'tokyo' => { id: 21, camps: [177, 213, 104, 118, 133] } }, { 'amsterdam' => { id: 12, camps: [166, 36, 74, 21, 97, 114, 144] } }, { 'melbourne' => { id: 28, camps: [180, 191] } }, { 'bali' => { id: 24, camps: [173, 203, 209] } }, { 'montreal' => { id: 2, camps: [158, 98, 208, 115, 146] } }, { 'belo-horizonte' => { id: 5, camps: [199, 174] } }, { 'paris' => { id: 19, camps: [183, 171, 196, 84, 179, 1, 16, 19, 34, 46, 94, 102, 2, 4, 5, 8, 9, 11, 12, 112, 153, 79, 147] } }, { 'shanghai' => { id: 3, camps: [206, 163, 113, 96, 127, 161] } }, { 'milan' => { id: 26, camps: [201, 175] } }, { 'rio' => { id: 4, camps: [86, 120, 182, 207, 160] } }, { 'sao-paulo' => { id: 6, camps: [186, 82, 50, 99, 119, 156] } }, { 'lisbon' => { id: 13, camps: [210, 211, 44, 176, 212, 103, 85, 145, 122] } }, { 'nantes' => { id: 11, camps: [188, 43, 83, 95, 150, 116] } }, { 'aix-marseille' => { id: 14, camps: [168, 185, 105, 128, 73, 142, 31, 89] } }, { 'lyon' => { id: 8, camps: [195, 178, 124, 88, 109, 159] } }, { 'berlin' => { id: 20, camps: [101, 129, 164, 151, 205] } }, { 'bordeaux' => { id: 15, camps: [193, 184, 87, 17, 20, 106, 47, 76, 148, 121] } }, { 'sydney' => { id: 27, camps: [181] } }, { 'budapest' => { id: 25, camps: [170] } }, { 'casablanca' => { id: 30, camps: [204] } }, { 'barcelona' => { id: 7, camps: [216, 165, 80, 93, 100, 132, 215, 154] } }]
    kitt_cities = [[9, 'london'], [29, 'recife'], [16, 'beirut'], [18, 'brussels'], [17, 'lille'], [10, 'copenhagen'], [22, 'chengdu'], [23, 'florianopolis'], [21, 'tokyo'], [12, 'amsterdam'], [28, 'melbourne'], [24, 'bali'], [2, 'montreal'], [5, 'belo-horizonte'], [19, 'paris'], [3, 'shanghai'], [26, 'milan'], [4, 'rio'], [6, 'sao-paulo'], [13, 'lisbon'], [11, 'nantes'], [14, 'aix-marseille'], [8, 'lyon'], [20, 'berlin'], [15, 'bordeaux'], [27, 'sydney'], [25, 'budapest'], [30, 'casablanca'], [7, 'barcelona']]
    alumni_batches = [{ id: 157, slug: nil }, { id: 156, slug: nil }, { id: 155, slug: nil }, { id: 154, slug: nil }, { id: 153, slug: '134' }, { id: 152, slug: nil }, { id: 151, slug: nil }, { id: 150, slug: nil }, { id: 149, slug: '135' }, { id: 148, slug: nil }, { id: 147, slug: '136' }, { id: 146, slug: nil }, { id: 145, slug: nil }, { id: 144, slug: nil }, { id: 143, slug: '129' }, { id: 142, slug: '124' }, { id: 141, slug: nil }, { id: 140, slug: '125' }, { id: 139, slug: '105' }, { id: 138, slug: '126' }, { id: 137, slug: '119' }, { id: 136, slug: '131' }, { id: 135, slug: nil }, { id: 134, slug: '137' }, { id: 133, slug: nil }, { id: 132, slug: '128' }, { id: 131, slug: '123' }, { id: 130, slug: '101' }, { id: 129, slug: '130' }, { id: 128, slug: '117' }, { id: 127, slug: '120' }, { id: 126, slug: '132' }, { id: 125, slug: '114' }, { id: 124, slug: '116' }, { id: 123, slug: '121' }, { id: 122, slug: '118' }, { id: 121, slug: nil }, { id: 120, slug: '122' }, { id: 119, slug: '112' }, { id: 118, slug: '107' }, { id: 117, slug: '99' }, { id: 115, slug: '113' }, { id: 114, slug: '110' }, { id: 113, slug: '106' }, { id: 112, slug: '98' }, { id: 111, slug: '94' }, { id: 110, slug: '104' }, { id: 109, slug: '' }, { id: 108, slug: '96' }, { id: 107, slug: '103' }, { id: 106, slug: '88' }, { id: 105, slug: '97' }, { id: 104, slug: '90' }, { id: 103, slug: '111' }, { id: 102, slug: '108' }, { id: 101, slug: '109' }, { id: 100, slug: '102' }, { id: 99, slug: '78' }, { id: 98, slug: '80' }, { id: 97, slug: '76' }, { id: 96, slug: '100' }, { id: 95, slug: '82' }, { id: 94, slug: '79' }, { id: 93, slug: '89' }, { id: 92, slug: '81' }, { id: 91, slug: '95' }, { id: 90, slug: '77' }, { id: 89, slug: '75' }, { id: 88, slug: '93' }, { id: 87, slug: '69' }, { id: 86, slug: '86' }, { id: 85, slug: '71' }, { id: 84, slug: '92' }, { id: 83, slug: '72' }, { id: 82, slug: '87' }, { id: 81, slug: '58' }, { id: 80, slug: '84' }, { id: 79, slug: '65' }, { id: 78, slug: '83' }, { id: 77, slug: '74' }, { id: 76, slug: '85' }, { id: 75, slug: '73' }, { id: 74, slug: '63' }, { id: 73, slug: '68' }, { id: 72, slug: '67' }, { id: 71, slug: '64' }, { id: 70, slug: '61' }, { id: 69, slug: '62' }, { id: 68, slug: '59' }, { id: 67, slug: '54' }, { id: 66, slug: '55' }, { id: 65, slug: '60' }, { id: 64, slug: '91' }, { id: 63, slug: '66' }, { id: 62, slug: '53' }, { id: 61, slug: '70' }, { id: 60, slug: '56' }, { id: 59, slug: '57' }, { id: 58, slug: '50' }, { id: 56, slug: '115' }, { id: 55, slug: '49' }, { id: 54, slug: '44' }, { id: 53, slug: '42' }, { id: 52, slug: '46' }, { id: 51, slug: '51' }, { id: 50, slug: '45' }, { id: 49, slug: '41' }, { id: 47, slug: '48' }, { id: 46, slug: '47' }, { id: 45, slug: '52' }, { id: 44, slug: '38' }, { id: 43, slug: '40' }, { id: 42, slug: '37' }, { id: 41, slug: '25' }, { id: 40, slug: '34' }, { id: 39, slug: '43' }, { id: 38, slug: '36' }, { id: 37, slug: '33' }, { id: 36, slug: '27' }, { id: 35, slug: '' }, { id: 34, slug: '39' }, { id: 33, slug: '26' }, { id: 32, slug: '31' }, { id: 31, slug: '20' }, { id: 29, slug: '29' }, { id: 28, slug: '' }, { id: 27, slug: '35' }, { id: 26, slug: '28' }, { id: 25, slug: '30' }, { id: 24, slug: '24' }, { id: 23, slug: '23' }, { id: 22, slug: '32' }, { id: 21, slug: '22' }, { id: 20, slug: '21' }, { id: 19, slug: '19' }, { id: 18, slug: '18' }, { id: 17, slug: '17' }, { id: 16, slug: '16' }, { id: 15, slug: '15' }, { id: 14, slug: '14' }, { id: 13, slug: '13' }, { id: 12, slug: '12' }, { id: 11, slug: '11' }, { id: 10, slug: '10' }, { id: 9, slug: '9' }, { id: 8, slug: '8' }, { id: 7, slug: '7' }, { id: 6, slug: '6' }, { id: 5, slug: '5' }, { id: 4, slug: '4' }, { id: 3, slug: '3' }, { id: 2, slug: '2' }, { id: 1, slug: '1' }]
    alumni_cities = [{ id: 31, slug: 'recife' }, { id: 30, slug: 'melbourne' }, { id: 29, slug: 'sydney' }, { id: 28, slug: 'milan' }, { id: 27, slug: 'budapest' }, { id: 26, slug: 'bali' }, { id: 25, slug: 'florianopolis' }, { id: 24, slug: 'chengdu' }, { id: 23, slug: 'tokyo' }, { id: 22, slug: 'berlin' }, { id: 21, slug: 'montreal' }, { id: 20, slug: 'shanghai' }, { id: 19, slug: 'rio' }, { id: 18, slug: 'belo-horizonte' }, { id: 17, slug: 'barcelona' }, { id: 16, slug: 'lyon' }, { id: 15, slug: 'sao-paulo' }, { id: 14, slug: 'london' }, { id: 13, slug: 'copenhagen' }, { id: 12, slug: 'nantes' }, { id: 11, slug: 'amsterdam' }, { id: 9, slug: 'lisbon' }, { id: 8, slug: 'aix-marseille' }, { id: 5, slug: 'bordeaux' }, { id: 4, slug: '-beirut' }, { id: 3, slug: 'lille' }, { id: 2, slug: 'brussels' }, { id: 1, slug: 'paris' }]

    Apply.find_in_batches do |applies|
      applies.each do |apply|
        # camp = kitt_camps.find { |c| c.values.first[:id] == apply.city_id }
        # if camp.values.first[:camps]&.include? apply.batch_id
        #   puts 'no migration needed'
        # else
        #   puts "need to migrate for #{apply.created_at}"
        # end

        # batch = alumni_batches.find { |b| b['id'] == apply.batch_id }
        # if batch && batch['slug']
        #   puts 'yay'
        # else
        #   puts 'nay!'
        # end
      end
    end
  end
end
