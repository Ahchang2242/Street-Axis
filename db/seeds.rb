# Clean up existing data
User.where(email: 'admin@example.com').destroy_all
User.where(username: 'admin').destroy_all
DanceStyle.destroy_all
Event.destroy_all
AboutUs.destroy_all
ContactInfo.destroy_all

# Create admin user
admin_user = User.new(
  email: 'admin@example.com',
  username: 'admin',
  password: 'Admin123!',
  password_confirmation: 'Admin123!',
  is_admin: true,
  online_status: 'offline'
)

if admin_user.save(validate: false)
  puts "Admin user created successfully!"
  puts "Email: admin@example.com"
  puts "Password: Admin123!"
else
  puts "Failed to create admin user:"
  puts admin_user.errors.full_messages
end

# Create dance styles
dance_styles = [
  {
    name: 'Breaking',
    description: 'Breaking是街舞中最古老和最具代表性的舞种之一，起源于20世纪70年代的纽约布朗克斯区。以其独特的地板动作、力量展示和节奏感著称。',
    image: ''
  },
  {
    name: 'Popping',
    description: 'Popping是一种通过肌肉快速收缩和放松产生"震动"效果的街舞风格，起源于20世纪70年代的加利福尼亚州。强调对音乐节拍的精准控制。',
    image: ''
  },
  {
    name: 'Locking',
    description: 'Locking起源于20世纪60年代末的洛杉矶，以突然"锁定"的动作和充满活力的表演风格著称。舞者通过快速的手臂和手部动作创造出独特的视觉效果。',
    image: ''
  },
  {
    name: 'Hip Hop',
    description: 'Hip Hop街舞融合了多种风格，起源于20世纪70年代的纽约。它强调自由表达和个人风格，是最受欢迎和最广泛传播的街舞形式之一。',
    image: ''
  },
  {
    name: 'Jazz Funk',
    description: 'Jazz Funk结合了爵士舞的优雅和街舞的活力，起源于20世纪80年代。它强调表现力和舞台魅力，常用于商业演出和音乐录影带。',
    image: ''
  },
  {
    name: 'Waacking',
    description: 'Waacking起源于20世纪70年代的洛杉矶同性恋俱乐部文化，以快速、流畅的手臂动作和戏剧性的姿态著称。它强调自信和舞台表现力。',
    image: ''
  }
]

dance_styles.each do |style|
  DanceStyle.create!(style)
  puts "Created dance style: #{style[:name]}"
end

# Create events
events = [
  {
    title: '2026年度街舞大赛',
    date: Date.new(2026, 6, 15),
    description: '一年一度的Street Axis街舞大赛即将拉开帷幕！来自全国各地的顶尖舞者将齐聚一堂，展示他们的技艺。欢迎所有街舞爱好者参加，现场还有精彩的嘉宾表演！',
    image: ''
  },
  {
    title: 'Breaking大师课',
    date: Date.new(2026, 5, 20),
    description: '特邀国际知名Breaking舞者来工作室授课！无论你是初学者还是有经验的舞者，都能从这次大师课中学到宝贵的技巧和经验。名额有限，先到先得！',
    image: ''
  },
  {
    title: '暑期街舞集训营',
    date: Date.new(2026, 7, 1),
    description: '为期一个月的暑期街舞集训营，涵盖Breaking、Popping、Hip Hop等多个舞种。由资深导师团队授课，帮助学员快速提升舞技，结交志同道合的朋友！',
    image: ''
  },
  {
    title: 'Street Axis周年庆典',
    date: Date.new(2026, 8, 10),
    description: '庆祝Street Axis成立16周年！当天将有精彩的学员汇报演出、教师团队表演，以及互动游戏和抽奖活动。感谢所有学员和家长一直以来的支持！',
    image: ''
  }
]

events.each do |event|
  Event.create!(event)
  puts "Created event: #{event[:title]}"
end

# Create about us
AboutUs.create!(
  mission: 'Street Axis街舞工作室成立于2010年，是一家专业的街舞培训机构，致力于推广街舞文化，培养优秀的街舞人才。我们的使命是让更多人了解和热爱街舞，通过舞蹈传递正能量和快乐。',
  teaching_philosophy: '我们坚持"以学生为中心"的教学理念，根据每个学生的特点和需求，制定个性化的学习计划。我们相信每个学生都有自己的潜能，通过专业的指导和不断的练习，都能在街舞的道路上取得进步。'
)
puts "Created About Us content"

# Create contact info
ContactInfo.create!(
  address: '北京市朝阳区建国路88号SOHO现代城A座12层',
  phone: '010-12345678',
  email: 'info@streetaxis.com',
  business_hours: '周一至周日 10:00-22:00'
)
puts "Created Contact Info content"

puts "Seed completed successfully!"
