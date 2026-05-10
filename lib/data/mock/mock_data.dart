import '../models/program_model.dart';
import '../models/expert_model.dart';

class MockData {
  MockData._();

  static final List<Expert> experts = [
    Expert(
      id: 'exp_01',
      name: 'Dr. Sarah Chen',
      title: 'Professor of AI & Data Science',
      company: 'Google DeepMind',
      experienceYears: 12,
      specializations: ['Machine Learning', 'Python', 'Deep Learning', 'NLP'],
      bio:
          'Dr. Sarah Chen leads the AI & Data Science faculty at Praktix University. With 12+ years at Google DeepMind, a PhD from MIT, and 30+ peer-reviewed publications, she brings world-class research into every sprint. Her philosophy: learn by doing, grow by teaching others.',
      imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      rating: 4.9,
      totalStudents: 1842,
      programIds: ['prog_01', 'prog_07'],
      linkedIn: 'https://linkedin.com/in/sarahchen',
    ),
    Expert(
      id: 'exp_02',
      name: 'Ahmed Al-Hassan',
      title: 'Associate Professor, Mobile Engineering',
      company: 'Meta',
      experienceYears: 8,
      specializations: ['Flutter', 'Dart', 'Mobile Architecture', 'Firebase'],
      bio:
          'Ahmed is a Flutter GDE and Associate Professor at Praktix University. With 8 years shipping production apps at Meta, his courses bridge academic rigour and industrial practice. Students publish four complete apps to real app stores during the program.',
      imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      rating: 4.8,
      totalStudents: 2140,
      programIds: ['prog_02'],
      linkedIn: 'https://linkedin.com/in/ahmedhassan',
    ),
    Expert(
      id: 'exp_03',
      name: 'Maria Rodriguez',
      title: 'Dean of Business & Entrepreneurship',
      company: 'Spotify',
      experienceYears: 10,
      specializations: ['Product Strategy', 'Agile', 'User Research', 'Entrepreneurship'],
      bio:
          'Maria serves as Dean of Business at Praktix University. Formerly Senior PM at Spotify and Airbnb (Stanford MBA), she brings a founder mindset to every sprint. Her Impact MBA cohorts tackle live business challenges with Fortune 500 partners.',
      imageUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
      rating: 4.9,
      totalStudents: 1280,
      programIds: ['prog_03', 'prog_08'],
      linkedIn: 'https://linkedin.com/in/mariarodriguez',
    ),
    Expert(
      id: 'exp_04',
      name: 'James Wilson',
      title: 'Professor of Human Experience Design',
      company: 'Apple',
      experienceYears: 15,
      specializations: ['UX Research', 'Figma', 'Design Systems', 'Interaction Design'],
      bio:
          'James is a Principal UX Designer at Apple and Professor of Human Experience at Praktix. 15 years shaping products used by a billion people inform every studio session. At Praktix, design students work in live cross-functional teams—just like the real world.',
      imageUrl: 'https://randomuser.me/api/portraits/men/75.jpg',
      rating: 4.8,
      totalStudents: 1420,
      programIds: ['prog_04'],
      linkedIn: 'https://linkedin.com/in/jameswilson',
    ),
    Expert(
      id: 'exp_05',
      name: 'Layla Osman',
      title: 'Professor of Marketing & Growth',
      company: 'HubSpot',
      experienceYears: 9,
      specializations: ['Digital Marketing', 'SEO', 'Paid Media', 'AI Tools'],
      bio:
          'Layla leads the Growth & Marketing faculty at Praktix. A HubSpot Growth Director who has scaled 20+ SaaS brands, she teaches data-driven strategy grounded in the latest tools and ethical frameworks. Her cohorts manage real ad budgets from week one.',
      imageUrl: 'https://randomuser.me/api/portraits/women/55.jpg',
      rating: 4.7,
      totalStudents: 930,
      programIds: ['prog_05'],
      linkedIn: 'https://linkedin.com/in/laylaosman',
    ),
    Expert(
      id: 'exp_06',
      name: 'Omar Farouq',
      title: 'Professor of Software Engineering',
      company: 'Stripe',
      experienceYears: 11,
      specializations: ['React', 'Node.js', 'System Design', 'TypeScript'],
      bio:
          'Omar is a Staff Engineer at Stripe and Professor of Software Engineering at Praktix. His program ships six production applications and graduates senior-level engineers in 16 weeks, backed by the Praktix Job Guarantee.',
      imageUrl: 'https://randomuser.me/api/portraits/men/62.jpg',
      rating: 4.9,
      totalStudents: 2100,
      programIds: ['prog_06'],
      linkedIn: 'https://linkedin.com/in/omarfarouq',
    ),
  ];

  static final List<Program> programs = [
    Program(
      id: 'prog_01',
      title: 'B.Sc. Artificial Intelligence & Data Science',
      category: 'Technology',
      duration: '24 months',
      price: 8900,
      imageUrl:
          'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&h=500&fit=crop',
      description:
          'A fully accredited Bachelor\'s degree that takes you from data fundamentals to frontier AI research. '
          'Structured in 18 learning sprints, each ending with a 1-on-1 project review with a senior professional. '
          'No lectures—only curated resources, hands-on projects, and peer review. '
          '\n\nYou will build a portfolio of 8+ industry-grade projects aligned with the UN SDGs. '
          '97.9% of our AI graduates secure roles within 6 months.',
      expertId: 'exp_01',
      outcomes: [
        'Build and deploy end-to-end ML pipelines from Python to production',
        'Design deep neural networks with TensorFlow and PyTorch',
        'Apply NLP, computer vision, and reinforcement learning to real problems',
        'Communicate data insights to business stakeholders with confidence',
        'Lead an AI research sprint aligned with UN Sustainable Development Goals',
        'Earn an accredited B.Sc. recognized by top tech companies globally',
      ],
      level: 'Beginner to Advanced',
      rating: 4.9,
      totalStudents: 1842,
      isFeatured: true,
      startDate: 'September 1, 2025',
      tags: ['AI', 'Machine Learning', 'Python', 'Bachelor', 'Accredited'],
    ),
    Program(
      id: 'prog_02',
      title: 'Certificate: Flutter & Mobile Engineering',
      category: 'Technology',
      duration: '10 weeks',
      price: 1299,
      imageUrl:
          'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800&h=500&fit=crop',
      description:
          'Go from zero to shipping production Flutter apps with real users. '
          'Sprint-based certificate covering Dart, Flutter UI, Riverpod, Clean Architecture, Firebase, and app-store deployment. '
          '\n\nYou build four complete apps—each reviewed by a senior Flutter GDE. '
          'Learn at your pace but with sprint deadlines to keep you on track.',
      expertId: 'exp_02',
      outcomes: [
        'Build pixel-perfect responsive Flutter UIs for iOS and Android',
        'Implement Riverpod and BLoC state management with Clean Architecture',
        'Integrate REST APIs and real-time Firebase features',
        'Write automated widget and unit tests',
        'Publish apps to App Store and Google Play',
        'Earn the Praktix Flutter Engineering Certificate',
      ],
      level: 'Beginner to Advanced',
      rating: 4.8,
      totalStudents: 2140,
      isFeatured: true,
      startDate: 'June 8, 2025',
      tags: ['Flutter', 'Dart', 'Mobile', 'Firebase', 'Certificate'],
    ),
    Program(
      id: 'prog_03',
      title: 'Impact MBA — Business Innovation & Leadership',
      category: 'Business',
      duration: '18 months',
      price: 12500,
      imageUrl:
          'https://images.unsplash.com/photo-1552664730-d307ca884978?w=800&h=500&fit=crop',
      description:
          'An accredited Impact MBA for purpose-driven professionals who want to lead transformation. '
          'Aligned with UN SDGs, combining business strategy, innovation, leadership, and entrepreneurship '
          'in live challenges with industry partners. '
          '\n\nNo traditional exams. Graduate with a full business case portfolio reviewed by Fortune 500 hiring managers.',
      expertId: 'exp_03',
      outcomes: [
        'Lead cross-functional teams using Agile, OKRs, and design thinking',
        'Develop and pitch a go-to-market strategy for a real business challenge',
        'Apply sustainability and impact frameworks to business decisions',
        'Present boardroom-ready cases to senior executives',
        'Build a global network through collaborative sprints with peers worldwide',
        'Graduate with an accredited Praktix Impact MBA',
      ],
      level: 'Intermediate',
      rating: 4.9,
      totalStudents: 1280,
      isFeatured: true,
      startDate: 'October 1, 2025',
      tags: ['MBA', 'Leadership', 'Entrepreneurship', 'Sustainability', 'Accredited'],
    ),
    Program(
      id: 'prog_04',
      title: 'M.Sc. Human Experience & Interaction Design',
      category: 'Design',
      duration: '12 months',
      price: 9800,
      imageUrl:
          'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800&h=500&fit=crop',
      description:
          'An accredited Master\'s in UX, interaction design, and human-centred research. '
          'Sprints cover user research, service design, accessibility, design systems, and AI-augmented workflows—'
          'reviewed with senior designers from Apple, Google, and Meta. '
          '\n\nGraduates lead design teams at top product companies within 3 months.',
      expertId: 'exp_04',
      outcomes: [
        'Conduct research that drives measurable product improvements',
        'Design end-to-end experiences from discovery to high-fidelity Figma',
        'Build and maintain scalable design systems',
        'Apply inclusive, accessible design principles',
        'Lead critique and design review sessions with stakeholders',
        'Earn an accredited M.Sc. in Human Experience Design',
      ],
      level: 'Intermediate to Advanced',
      rating: 4.8,
      totalStudents: 1420,
      isFeatured: false,
      startDate: 'September 15, 2025',
      tags: ['UX', 'Figma', 'Design Systems', "Master's", 'Accredited'],
    ),
    Program(
      id: 'prog_05',
      title: 'Certificate: AI for Business',
      category: 'Business',
      duration: '6 weeks',
      price: 699,
      imageUrl:
          'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=500&fit=crop',
      description:
          'Master AI tools for work in 6 weeks at 4 hours/week. No coding required. '
          'You will use ChatGPT, Copilot, and Gemini to automate workflows, analyze data, and create compelling content. '
          '\n\nFollows the Praktix sprint model: learn → apply → review. '
          'A capstone project lets you build an AI-powered solution to a real business challenge.',
      expertId: 'exp_05',
      outcomes: [
        'Use generative AI tools effectively and responsibly at work',
        'Automate repetitive workflows using AI and no-code tools',
        'Analyze data and generate insights with AI assistance',
        'Create reports, presentations, and media using AI tools',
        'Build and present an AI-powered capstone project',
        'Earn the Praktix AI for Business Certificate',
      ],
      level: 'Beginner',
      rating: 4.7,
      totalStudents: 930,
      isFeatured: false,
      startDate: 'July 1, 2025',
      tags: ['AI', 'No-code', 'Productivity', 'Business', 'Certificate'],
    ),
    Program(
      id: 'prog_06',
      title: 'B.Sc. Software Engineering (Full-Stack)',
      category: 'Technology',
      duration: '16 weeks',
      price: 3200,
      imageUrl:
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800&h=500&fit=crop',
      description:
          'The most comprehensive full-stack accelerator available. Learn React, TypeScript, Node.js, '
          'PostgreSQL, and cloud deployment from a Staff Engineer at Stripe. '
          '\n\nYou build 6 production applications and graduate as a senior-level engineer in 16 weeks—'
          'backed by the Praktix Job Guarantee.',
      expertId: 'exp_06',
      outcomes: [
        'Build full-stack applications with React, TypeScript, and Node.js',
        'Design RESTful APIs and GraphQL services at production scale',
        'Model relational databases with PostgreSQL',
        'Deploy to AWS with CI/CD pipelines',
        'Apply system design principles for scalable architecture',
        'Graduate job-ready with the Praktix Job Guarantee',
      ],
      level: 'Intermediate',
      rating: 4.9,
      totalStudents: 2100,
      isFeatured: true,
      startDate: 'June 1, 2025',
      tags: ['React', 'Node.js', 'TypeScript', 'AWS', 'Job Guarantee'],
    ),
    Program(
      id: 'prog_07',
      title: 'Impact Certificate: Sustainability & AI',
      category: 'Technology',
      duration: '8 weeks',
      price: 890,
      imageUrl:
          'https://images.unsplash.com/photo-1508514177221-188b1cf16e9d?w=800&h=500&fit=crop',
      description:
          'Explore the intersection of AI and sustainable development. '
          'This impact-focused certificate applies AI to climate data, ESG reporting, and social impact analysis, '
          'aligned with UN SDGs. '
          '\n\nStack it with any Praktix degree for credit recognition, or complete it standalone as a flexible elective.',
      expertId: 'exp_01',
      outcomes: [
        'Apply AI and data science to sustainability challenges',
        'Analyze climate and ESG data with Python and visualization tools',
        'Design AI solutions aligned with UN Sustainable Development Goals',
        'Present impact findings to executives and investors',
        'Build a personal mission statement to guide your career',
        'Stack with any Praktix degree for credit',
      ],
      level: 'Beginner to Intermediate',
      rating: 4.8,
      totalStudents: 620,
      isFeatured: false,
      startDate: 'August 1, 2025',
      tags: ['AI', 'Sustainability', 'UN SDGs', 'ESG', 'Impact'],
    ),
    Program(
      id: 'prog_08',
      title: 'Executive Leadership Program',
      category: 'Business',
      duration: '3 months',
      price: 4500,
      imageUrl:
          'https://images.unsplash.com/photo-1521791136064-7986c2920216?w=800&h=500&fit=crop',
      description:
          'For senior professionals ready to lead at a new level. '
          'Develops the mindset, global network, and decision-making skills for C-suite and board-level roles. '
          '\n\nThrough live sprints, executive coaching, and a global peer cohort, you tackle '
          'real leadership challenges and graduate with the confidence to drive transformative change.',
      expertId: 'exp_03',
      outcomes: [
        'Lead organisational transformation with clarity and purpose',
        'Build executive presence and strategic communication skills',
        'Apply advanced leadership frameworks in real scenarios',
        'Develop a personal leadership philosophy and 90-day action plan',
        'Access the Praktix global alumni network of 10,000+ leaders',
        'Receive the Praktix Executive Leadership Certificate',
      ],
      level: 'Advanced',
      rating: 4.9,
      totalStudents: 340,
      isFeatured: false,
      startDate: 'September 1, 2025',
      tags: ['Leadership', 'Executive', 'C-Suite', 'Strategy', 'Certificate'],
    ),
  ];

  static Expert? findExpertById(String id) {
    try {
      return experts.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  static Program? findProgramById(String id) {
    try {
      return programs.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<Program> programsByExpert(String expertId) =>
      programs.where((p) => p.expertId == expertId).toList();
}
