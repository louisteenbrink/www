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

  task remove_test: :environment do
    Apply.all.each do |apply|
      if apply.motivation.match?(/test ?test/i) \
        || apply.email.match?(/test/i)
        apply.destroy
        puts "Removed #{apply.email}"
      end
    end
  end

  task migrate: :environment do
    alumni_batches = [[157, nil], [156, nil], [155, nil], [154, nil], [153, '134'], [152, nil], [151, nil], [150, nil], [149, '135'], [148, nil], [147, '136'], [146, nil], [145, nil], [144, nil], [143, '129'], [142, '124'], [141, nil], [140, '125'], [139, '105'], [138, '126'], [137, '119'], [136, '131'], [135, nil], [134, '137'], [133, nil], [132, '128'], [131, '123'], [130, '101'], [129, '130'], [128, '117'], [127, '120'], [126, '132'], [125, '114'], [124, '116'], [123, '121'], [122, '118'], [121, nil], [120, '122'], [119, '112'], [118, '107'], [117, '99'], [115, '113'], [114, '110'], [113, '106'], [112, '98'], [111, '94'], [110, '104'], [109, ''], [108, '96'], [107, '103'], [106, '88'], [105, '97'], [104, '90'], [103, '111'], [102, '108'], [101, '109'], [100, '102'], [99, '78'], [98, '80'], [97, '76'], [96, '100'], [95, '82'], [94, '79'], [93, '89'], [92, '81'], [91, '95'], [90, '77'], [89, '75'], [88, '93'], [87, '69'], [86, '86'], [85, '71'], [84, '92'], [83, '72'], [82, '87'], [81, '58'], [80, '84'], [79, '65'], [78, '83'], [77, '74'], [76, '85'], [75, '73'], [74, '63'], [73, '68'], [72, '67'], [71, '64'], [70, '61'], [69, '62'], [68, '59'], [67, '54'], [66, '55'], [65, '60'], [64, '91'], [63, '66'], [62, '53'], [61, '70'], [60, '56'], [59, '57'], [58, '50'], [56, '115'], [55, '49'], [54, '44'], [53, '42'], [52, '46'], [51, '51'], [50, '45'], [49, '41'], [47, '48'], [46, '47'], [45, '52'], [44, '38'], [43, '40'], [42, '37'], [41, '25'], [40, '34'], [39, '43'], [38, '36'], [37, '33'], [36, '27'], [35, ''], [34, '39'], [33, '26'], [32, '31'], [31, '20'], [29, '29'], [28, ''], [27, '35'], [26, '28'], [25, '30'], [24, '24'], [23, '23'], [22, '32'], [21, '22'], [20, '21'], [19, '19'], [18, '18'], [17, '17'], [16, '16'], [15, '15'], [14, '14'], [13, '13'], [12, '12'], [11, '11'], [10, '10'], [9, '9'], [8, '8'], [7, '7'], [6, '6'], [5, '5'], [4, '4'], [3, '3'], [2, '2'], [1, '1']]
    kitt_camps = [[33, "23"], [81, "45"], [143, "96"], [90, "54"], [199, nil], [167, "116"], [152, "104"], [166, "126"], [180, "135"], [183, "1"], [216, nil], [165, "129"], [158, "125"], [210, nil], [169, "118"], [91, "55"], [108, "69"], [42, "26"], [181, "136"], [168, "117"], [190, nil], [211, nil], [192, nil], [197, nil], [44, "28"], [189, nil], [185, nil], [193, nil], [195, nil], [194, nil], [186, nil], [171, "120"], [184, nil], [174, "115"], [200, nil], [198, nil], [191, nil], [187, nil], [214, nil], [170, "119"], [77, "41"], [130, "93"], [92, "56"], [107, "68"], [173, "128"], [196, nil], [123, "87"], [176, "122"], [80, "44"], [93, "57"], [206, nil], [87, "51"], [10, "9"], [84, "48"], [82, "46"], [212, nil], [179, "134"], [111, "74"], [103, "71"], [72, "36"], [105, "66"], [17, "16"], [20, "19"], [172, "123"], [106, "67"], [1, "2"], [16, "15"], [19, "18"], [50, "34"], [177, "132"], [98, "63"], [34, "24"], [46, "30"], [94, "59"], [102, "70"], [2, "3"], [4, "4"], [163, "130"], [113, "76"], [101, "65"], [202, nil], [204, nil], [188, nil], [45, "29"], [47, "31"], [86, "50"], [120, "84"], [99, "64"], [43, "27"], [36, "25"], [128, "91"], [178, "121"], [124, "82"], [129, "92"], [182, "137"], [164, "124"], [207, nil], [48, "32"], [49, "33"], [78, "42"], [71, "35"], [75, "39"], [74, "38"], [76, "40"], [73, "37"], [149, "103"], [7, "7"], [18, "17"], [5, "5"], [8, "6"], [9, "8"], [11, "10"], [12, "11"], [203, nil], [142, "89"], [151, "111"], [205, nil], [6, "staff"], [13, "12"], [14, "13"], [32, "22"], [21, "20"], [112, "83"], [31, "21"], [208, nil], [153, "101"], [209, nil], [213, nil], [15, "14"], [201, nil], [88, "52"], [104, "58"], [110, "73"], [97, "62"], [114, "80"], [115, "77"], [79, "43"], [96, "61"], [100, "75"], [83, "47"], [95, "60"], [85, "49"], [89, "53"], [109, "72"], [145, "97"], [118, "78"], [148, "102"], [150, "107"], [146, "98"], [125, "88"], [147, "100"], [144, "99"], [121, "85"], [127, "90"], [119, "81"], [132, "95"], [116, "79"], [122, "86"], [133, "94"], [155, "105"], [157, "108"], [160, "110"], [161, "112"], [156, "106"], [162, "114"], [175, "131"], [215, nil], [154, "113"], [159, "109"]]

    alumni_batches.each do |alumni_batch|
      applications = Apply.where(batch_id: alumni_batch.first)
      camp = kitt_camps.find { |c| c.last == alumni_batch.last }
      if camp
        applications.each do |a|
          a.update_attribute('batch_id', camp.first)
        end
        puts "migrated #{alumni_batch.first} to kitt #{camp.first}"
      else
        applications.each do |a|
          a.update_attribute('batch_id', nil)
        end
        puts "migrated #{alumni_batch.first} to nil batch_id"
      end
    end
  end

  task send_all_to_kitt: :environment do
    puts "=== Sending #{Apply.count} appications to Kitt ==="
    i = 1
    Apply.find_in_batches do |applies|
      applies.each do |apply|
        begin
          PushApplyToKittRunner.new(apply).run
          puts "#{i}. Pushed #{apply.email}"
        rescue Exception => e
          puts "#{i} ⚠️  Error for #{apply.email}: #{e.message} - #{e.response.body}"
        ensure
          i += 1
        end
      end
    end
    puts '=== Done! ==='
  end

  task seed_crm_cards_www_apply_id: :environment do
    applies = Apply.where('created_at > ?', Date.new(2016, 10, 1)).group(:email).count
    # applies = Apply.where(batch_id: 196).group(:email).count
    multi_applies = []
    applies.each do |email, count|
      if count == 1
        begin
          PushApplyIdToCrmRunner.new(email).run
          puts "Pushed #{email}"
        rescue Exception => e
          puts "⚠️  Error for #{email}: #{e.message} - #{e.response.body}"
        end
      else
        multi_applies << email
      end
    end
    puts "Multi applies:"
    puts multi_applies
  end
end
