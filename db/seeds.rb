Program.destroy_all
Day.destroy_all
Category.destroy_all
Activity.destroy_all
DailyActivity.destroy_all

program = Program.create!(name: "Month Plan", description: "5-min/day activities for children")
categories = ["Athleticism","Boosters","Music","Memory","Creativity","Languages","Athleticism","Creativity","Logic"]

category_records = {}
categories.each do |cat|
	category_records[cat] = Category.create!(name: cat)
end

activity_data = [
  ["Advanced Mobility exercises", "Athleticism", "Maximize", 60],
  ["Knowledge Boosters (Follow daily plans)", "Boosters", "2x/Day", 30],
  ["Visual Solfege", "Music", "1x/Day", 30],
  ["Auditory Memory (Song 2)", "Memory", "1x/Day", 30],
  ["Auditory Magic (Set 2)", "Creativity", "2 sounds/day", 60],
  ["Talk, To Listen", "Languages", "1x/Day", 60],
  ["Finger Skills", "Athleticism", "3x/Week", 60],
  ["Stimulus Explosion", "Creativity", "2x/Week", 60],
  ["Foundations of Logic (Quantity)", "Logic", "3x/Week", 60],
]

activity_records = {}
activity_data.each do |key_name, cat_name, freq, duration|
  activity_records[key_name] = Activity.create!(
    title: key_name,
    description:"",
    category: category_records[cat_name],
    frequency: freq,
    duration_in_sec: duration
  )
end

(1..7).each do |day_number|
  Day.create!(day_number: day_number, program: program)
end

daywise_activities = {
  1 => ["Advanced Mobility exercises", "Knowledge Boosters (Follow daily plans)", "Visual Solfege", "Auditory Memory (Song 2)", "Auditory Magic (Set 2)", "Talk, To Listen", "Finger Skills"],
  2 => ["Advanced Mobility exercises", "Knowledge Boosters (Follow daily plans)", "Visual Solfege", "Auditory Memory (Song 2)", "Auditory Magic (Set 2)", "Talk, To Listen", "Foundations of Logic (Quantity)"],
  3 => ["Advanced Mobility exercises", "Knowledge Boosters (Follow daily plans)", "Visual Solfege", "Auditory Memory (Song 2)", "Auditory Magic (Set 2)", "Talk, To Listen", "Stimulus Explosion"],
  4 => ["Advanced Mobility exercises", "Knowledge Boosters (Follow daily plans)", "Visual Solfege", "Auditory Memory (Song 2)", "Auditory Magic (Set 2)", "Talk, To Listen", "Finger Skills"],
  2 => ["Advanced Mobility exercises", "Knowledge Boosters (Follow daily plans)", "Visual Solfege", "Auditory Memory (Song 2)", "Auditory Magic (Set 2)", "Talk, To Listen", "Foundations of Logic (Quantity)"],
  3 => ["Advanced Mobility exercises", "Knowledge Boosters (Follow daily plans)", "Visual Solfege", "Auditory Memory (Song 2)", "Auditory Magic (Set 2)", "Talk, To Listen", "Stimulus Explosion"],
  7 => ["Advanced Mobility exercises", "Knowledge Boosters (Follow daily plans)", "Visual Solfege", "Auditory Memory (Song 2)", "Auditory Magic (Set 2)", "Talk, To Listen", "Finger Skills"]
}

daywise_activities.each do |day_num, activities_list|
	day = Day.find_by(day_number: day_num)
	activities_list.each do |activity_key_name|
		DailyActivity.create!(day: day, activity: activity_records[activity_key_name])
	end
end