import '../models/program_model.dart';
import '../models/expert_model.dart';

class MockData {
  MockData._();

  // ── Experts ──────────────────────────────────────────────
  static final List<Expert> experts = [
    Expert(
      id: 'exp_01',
      name: 'Dr. Sarah Chen',
      title: 'Lead Data Scientist',
      company: 'Google DeepMind',
      experienceYears: 12,
      specializations: ['Machine Learning', 'Python', 'Deep Learning', 'NLP'],
      bio:
          'Dr. Sarah Chen is a leading Data Scientist with 12+ years of experience at Google DeepMind. '
          'She holds a PhD in Computer Science from MIT and has published over 30 peer-reviewed papers '
          'on machine learning and AI. Sarah has mentored over 800 students globally and is passionate '
          'about making data science accessible to everyone.',
      imageUrl: 'https://ui-avatars.com/api/?name=Sarah+Chen&background=6C63FF&color=fff&size=128&bold=true',
      rating: 4.9,
      totalStudents: 842,
      programIds: ['prog_01'],
      linkedIn: 'https://linkedin.com/in/sarahchen',
    ),
    Expert(
      id: 'exp_02',
      name: 'Ahmed Al-Hassan',
      title: 'Senior Flutter Engineer',
      company: 'Meta',
      experienceYears: 8,
      specializations: ['Flutter', 'Dart', 'Mobile Architecture', 'Firebase'],
      bio:
          'Ahmed is a Senior Mobile Engineer at Meta with 8 years of experience building production '
          'mobile applications used by millions. He is a Flutter GDE (Google Developer Expert) and '
          'has contributed to multiple open-source packages. His teaching style focuses on real-world '
          'architecture and shipping apps that scale.',
      imageUrl: 'https://ui-avatars.com/api/?name=Ahmed+Hassan&background=00C98D&color=fff&size=128&bold=true',
      rating: 4.8,
      totalStudents: 1240,
      programIds: ['prog_02'],
      linkedIn: 'https://linkedin.com/in/ahmedhassan',
    ),
    Expert(
      id: 'exp_03',
      name: 'Maria Rodriguez',
      title: 'Senior Product Manager',
      company: 'Spotify',
      experienceYears: 10,
      specializations: ['Product Strategy', 'Agile', 'User Research', 'OKRs'],
      bio:
          'Maria is a Senior PM at Spotify with 10 years of experience launching products used by '
          '500M+ users. She previously led product teams at Airbnb and has an MBA from Stanford. '
          'Maria brings a founder mindset to product management and teaches frameworks that actually '
          'work in fast-paced environments.',
      imageUrl: 'https://ui-avatars.com/api/?name=Maria+Rodriguez&background=FF6B4A&color=fff&size=128&bold=true',
      rating: 4.9,
      totalStudents: 680,
      programIds: ['prog_03'],
      linkedIn: 'https://linkedin.com/in/mariarodriguez',
    ),
    Expert(
      id: 'exp_04',
      name: 'James Wilson',
      title: 'Principal UX Designer',
      company: 'Apple',
      experienceYears: 15,
      specializations: ['UX Research', 'Figma', 'Design Systems', 'Prototyping'],
      bio:
          'James is a Principal UX Designer at Apple with 15 years of experience shaping iconic '
          'user experiences. He has led design for products with over 1B users. A Figma ambassador '
          'and speaker at Config, James combines deep craft with systems thinking to create '
          'experiences that feel inevitable.',
      imageUrl: 'https://ui-avatars.com/api/?name=James+Wilson&background=F5A623&color=fff&size=128&bold=true',
      rating: 4.8,
      totalStudents: 920,
      programIds: ['prog_04'],
      linkedIn: 'https://linkedin.com/in/jameswilson',
    ),
    Expert(
      id: 'exp_05',
      name: 'Layla Osman',
      title: 'Growth Marketing Director',
      company: 'HubSpot',
      experienceYears: 9,
      specializations: ['Digital Marketing', 'SEO', 'Paid Media', 'Analytics'],
      bio:
          'Layla leads growth marketing at HubSpot, having grown multiple SaaS brands from seed to '
          'Series C. With experience across SEO, paid media, email, and analytics, she takes a '
          'data-driven approach to every campaign. She has trained marketing teams at over 50 companies.',
      imageUrl: 'https://ui-avatars.com/api/?name=Layla+Osman&background=3A86FF&color=fff&size=128&bold=true',
      rating: 4.7,
      totalStudents: 530,
      programIds: ['prog_05'],
      linkedIn: 'https://linkedin.com/in/laylaosman',
    ),
    Expert(
      id: 'exp_06',
      name: 'Omar Farouq',
      title: 'Staff Software Engineer',
      company: 'Stripe',
      experienceYears: 11,
      specializations: ['React', 'Node.js', 'System Design', 'TypeScript'],
      bio:
          'Omar is a Staff Engineer at Stripe, where he architects high-availability payment systems. '
          'With 11 years in full-stack development, he has built and scaled products handling '
          'billions in transactions. Omar is a mentor at YC and passionate about teaching '
          'engineers to think at the systems level.',
      imageUrl: 'https://ui-avatars.com/api/?name=Omar+Farouq&background=A09AFF&color=fff&size=128&bold=true',
      rating: 4.9,
      totalStudents: 1100,
      programIds: ['prog_06'],
      linkedIn: 'https://linkedin.com/in/omarfarouq',
    ),
    Expert(
      id: 'exp_07',
      name: 'Dr. Amara Nwosu',
      title: 'Director of Sustainability & Tech',
      company: 'World Economic Forum',
      experienceYears: 14,
      specializations: ['Sustainable Tech', 'AI Ethics', 'Climate Policy', 'SDGs'],
      bio:
          'Dr. Amara Nwosu bridges technology and sustainability at the World Economic Forum, '
          'advising Fortune 500 companies on their net-zero roadmaps and AI governance. '
          'She has spoken at COP27/28 and designed sustainability curricula adopted by '
          '12 universities globally. Her teaching fuses systems thinking with practical tech solutions.',
      imageUrl: 'https://ui-avatars.com/api/?name=Amara+Nwosu&background=1A8C5B&color=fff&size=128&bold=true',
      rating: 4.9,
      totalStudents: 390,
      programIds: ['prog_07', 'prog_08'],
      linkedIn: 'https://linkedin.com/in/amaranwosu',
    ),
    Expert(
      id: 'exp_08',
      name: 'Prof. Elena Volkov',
      title: 'Dean of Innovation',
      company: 'Berlin School of Business & Innovation',
      experienceYears: 18,
      specializations: ['Entrepreneurship', 'Impact Ventures', 'Circular Economy', 'Leadership'],
      bio:
          'Prof. Elena Volkov has founded three companies and advised over 200 impact startups '
          'across Europe and Africa. As Dean of Innovation at BSBI Berlin, she redesigned the '
          'MBA curriculum around real-world challenges aligned with the UN SDGs. Her research on '
          'circular business models has been cited in 80+ academic papers.',
      imageUrl: 'https://ui-avatars.com/api/?name=Elena+Volkov&background=2B7ABA&color=fff&size=128&bold=true',
      rating: 4.8,
      totalStudents: 620,
      programIds: ['prog_09'],
      linkedIn: 'https://linkedin.com/in/elenavolkov',
    ),
  ];

  // ── Programs ─────────────────────────────────────────────
  static final List<Program> programs = [
    // ── Short Courses ──────────────────────────────────────
    Program(
      id: 'prog_01',
      title: 'Data Science & Machine Learning',
      category: 'Technology',
      duration: '12 weeks',
      price: 1299,
      imageUrl: 'https://picsum.photos/seed/data/800/500',
      description:
          'Master the art and science of data from first principles to cutting-edge ML models. '
          'This intensive program covers Python, statistical analysis, machine learning algorithms, '
          'deep learning, and real-world project deployment. You will work on 5+ industry-grade '
          'projects with datasets from companies like Uber, Netflix, and Spotify. '
          '\n\nBy graduation, you will have the technical depth and portfolio to land roles as a '
          'Data Scientist, ML Engineer, or AI Analyst at top-tier companies.',
      expertId: 'exp_01',
      outcomes: [
        'Build end-to-end ML pipelines using Python and scikit-learn',
        'Design and train deep neural networks with TensorFlow & PyTorch',
        'Apply NLP techniques for text classification and sentiment analysis',
        'Perform exploratory data analysis using Pandas & NumPy',
        'Deploy ML models to production with FastAPI and Docker',
        'Communicate insights effectively with Matplotlib and Tableau',
      ],
      level: 'Intermediate',
      rating: 4.9,
      totalStudents: 842,
      isFeatured: true,
      startDate: 'June 1, 2025',
      tags: ['Python', 'ML', 'AI', 'Deep Learning', 'Data'],
      programType: 'course',
      sdgGoals: ['SDG 4 – Quality Education', 'SDG 9 – Industry Innovation'],
    ),
    Program(
      id: 'prog_02',
      title: 'Flutter Mobile Development',
      category: 'Technology',
      duration: '10 weeks',
      price: 999,
      imageUrl: 'https://picsum.photos/seed/mobile/800/500',
      description:
          'Go from zero to shipping production Flutter apps used by real users. This program covers '
          'Dart fundamentals, Flutter UI construction, state management with Riverpod and BLoC, '
          'Clean Architecture, and Firebase integration. '
          '\n\nYou will build 4 complete apps — a social media clone, an e-commerce app, a fitness '
          'tracker, and a custom project of your own. Each app ships to the App Store and Play Store.',
      expertId: 'exp_02',
      outcomes: [
        'Build pixel-perfect, responsive Flutter UIs for iOS and Android',
        'Implement state management using Riverpod and BLoC patterns',
        'Structure projects using Clean Architecture and MVVM',
        'Integrate REST APIs and real-time data with Firebase',
        'Write automated widget and unit tests for Flutter apps',
        'Deploy and publish apps to App Store and Google Play',
      ],
      level: 'Beginner to Advanced',
      rating: 4.8,
      totalStudents: 1240,
      isFeatured: true,
      startDate: 'June 8, 2025',
      tags: ['Flutter', 'Dart', 'iOS', 'Android', 'Firebase'],
      programType: 'course',
      sdgGoals: ['SDG 4 – Quality Education'],
    ),
    Program(
      id: 'prog_03',
      title: 'Product Management Fundamentals',
      category: 'Business',
      duration: '8 weeks',
      price: 799,
      imageUrl: 'https://picsum.photos/seed/product/800/500',
      description:
          'Learn to think, speak, and execute like a world-class Product Manager. Covering discovery, '
          'strategy, prioritization, Agile, metrics, and stakeholder alignment — this program is '
          'grounded in real practices from Spotify, Airbnb, and Google. '
          '\n\nYou will build a full product case study from scratch, including user research, '
          'PRDs, roadmaps, and go-to-market planning.',
      expertId: 'exp_03',
      outcomes: [
        'Run structured user research to uncover real product opportunities',
        'Write clear Product Requirements Documents (PRDs)',
        'Build and prioritize a product roadmap using OKR frameworks',
        'Lead cross-functional teams using Agile and Scrum',
        'Define, track, and improve key product metrics',
        'Ace PM interviews at top tech companies',
      ],
      level: 'Beginner',
      rating: 4.9,
      totalStudents: 680,
      isFeatured: true,
      startDate: 'June 15, 2025',
      tags: ['Product', 'Strategy', 'Agile', 'OKRs', 'Roadmap'],
      programType: 'course',
      sdgGoals: ['SDG 8 – Decent Work & Economic Growth'],
    ),
    Program(
      id: 'prog_04',
      title: 'UX/UI Design Masterclass',
      category: 'Design',
      duration: '10 weeks',
      price: 899,
      imageUrl: 'https://picsum.photos/seed/design/800/500',
      description:
          'Transform your design thinking and craft world-class digital experiences. This program '
          'covers UX research, information architecture, interaction design, visual design, '
          'and design systems. You will work in Figma daily, building a portfolio of 3 full '
          'case studies reviewed by senior designers at Apple and Google. '
          '\n\nGraduates regularly land roles at top product companies within 3 months.',
      expertId: 'exp_04',
      outcomes: [
        'Conduct user interviews, usability tests, and synthesize findings',
        'Create wireframes, user flows, and low/high-fidelity prototypes',
        'Build and maintain scalable design systems in Figma',
        'Apply visual design principles: typography, color, layout, motion',
        'Collaborate effectively with engineers in a handoff workflow',
        'Present design decisions with confidence to stakeholders',
      ],
      level: 'Beginner to Intermediate',
      rating: 4.8,
      totalStudents: 920,
      isFeatured: false,
      startDate: 'June 22, 2025',
      tags: ['Figma', 'UX', 'UI', 'Design Systems', 'Prototyping'],
      programType: 'course',
      sdgGoals: ['SDG 10 – Reduced Inequalities'],
    ),
    Program(
      id: 'prog_05',
      title: 'Digital Marketing Strategy',
      category: 'Marketing',
      duration: '6 weeks',
      price: 599,
      imageUrl: 'https://picsum.photos/seed/marketing/800/500',
      description:
          'Master full-funnel digital marketing from brand strategy to performance analytics. '
          'This program covers SEO, paid media (Google & Meta Ads), email marketing, content '
          'strategy, and conversion rate optimization. You will manage a real ad budget and '
          'run live campaigns during the program. '
          '\n\nIdeal for founders, marketers, and anyone wanting to grow a business online.',
      expertId: 'exp_05',
      outcomes: [
        'Develop a data-driven digital marketing strategy from scratch',
        'Launch and optimize Google Ads and Meta ad campaigns',
        'Implement technical and on-page SEO for organic growth',
        'Build automated email sequences that convert leads to customers',
        'Analyze campaign performance with Google Analytics 4',
        'Calculate and improve CAC, ROAS, and LTV',
      ],
      level: 'Beginner',
      rating: 4.7,
      totalStudents: 530,
      isFeatured: false,
      startDate: 'July 1, 2025',
      tags: ['SEO', 'Ads', 'Email', 'Analytics', 'Growth'],
      programType: 'course',
      sdgGoals: ['SDG 8 – Decent Work & Economic Growth'],
    ),
    Program(
      id: 'prog_06',
      title: 'Full-Stack Web Development',
      category: 'Technology',
      duration: '16 weeks',
      price: 1499,
      imageUrl: 'https://picsum.photos/seed/code/800/500',
      description:
          'The most comprehensive full-stack program available. Learn React, TypeScript, Node.js, '
          'PostgreSQL, and cloud deployment from an engineer who has shipped at scale. '
          '\n\nYou will build and deploy 6 real applications including a SaaS platform, REST API, '
          'real-time chat app, and a personal portfolio. The program emphasizes system design, '
          'performance, and the engineering practices that matter at senior levels.',
      expertId: 'exp_06',
      outcomes: [
        'Build full-stack applications with React, TypeScript and Node.js',
        'Design and implement RESTful APIs and GraphQL services',
        'Model relational databases with PostgreSQL and write complex queries',
        'Deploy applications on AWS with CI/CD pipelines',
        'Write comprehensive tests with Jest, React Testing Library',
        'Apply system design principles for scalable architectures',
      ],
      level: 'Intermediate',
      rating: 4.9,
      totalStudents: 1100,
      isFeatured: true,
      startDate: 'June 1, 2025',
      tags: ['React', 'Node.js', 'TypeScript', 'PostgreSQL', 'AWS'],
      programType: 'course',
      sdgGoals: ['SDG 9 – Industry Innovation', 'SDG 8 – Decent Work'],
    ),

    // ── Accredited Degrees ─────────────────────────────────
    Program(
      id: 'prog_07',
      title: 'B.Sc. Artificial Intelligence & Sustainable Technologies',
      category: 'Sustainability',
      duration: '3 years',
      price: 9800,
      imageUrl: 'https://picsum.photos/seed/aitech/800/500',
      description:
          'A fully remote, state-accredited bachelor\'s degree merging AI engineering with '
          'sustainable technology design. You will master machine learning, climate data science, '
          'green computing, and responsible AI — guided by practitioners from the World Economic Forum, '
          'Google, and leading climate-tech companies. '
          '\n\nEvery module delivers via challenge-based sprints tied to real UN SDG projects. '
          'No traditional exams — your portfolio of 20+ real-world solutions IS your degree.',
      expertId: 'exp_07',
      outcomes: [
        'Build and deploy AI systems that optimize energy consumption',
        'Analyze climate datasets to inform policy and product decisions',
        'Apply ethical AI principles and governance frameworks',
        'Design circular-economy tech solutions for enterprise clients',
        'Lead interdisciplinary teams tackling sustainability challenges',
        'Graduate with a portfolio of 20+ industry-reviewed projects',
      ],
      level: 'Beginner to Advanced',
      rating: 4.9,
      totalStudents: 390,
      isFeatured: true,
      startDate: 'September 1, 2025',
      tags: ['AI', 'Sustainability', 'Climate', 'Bachelor\'s', 'SDGs'],
      programType: 'degree',
      degreeType: 'Bachelor\'s',
      ects: 180,
      sdgGoals: [
        'SDG 4 – Quality Education',
        'SDG 7 – Clean Energy',
        'SDG 9 – Industry Innovation',
        'SDG 13 – Climate Action',
      ],
    ),
    Program(
      id: 'prog_08',
      title: 'M.Sc. Sustainable Technologies & AI',
      category: 'Sustainability',
      duration: '2 years',
      price: 13500,
      imageUrl: 'https://picsum.photos/seed/sustain/800/500',
      description:
          'An advanced master\'s program for professionals who want to lead the intersection of '
          'technology and planetary impact. Dive deep into AI governance, climate fintech, '
          'green software engineering, and sustainable business model design. '
          '\n\nStudy in a cohort of 30 change-makers from 40+ countries. Monthly in-person city '
          'hubs in Berlin, London, and Nairobi bring the community together beyond the screen.',
      expertId: 'exp_07',
      outcomes: [
        'Lead AI transformation projects with sustainability at the core',
        'Design responsible data systems compliant with EU AI Act',
        'Build climate-fintech products from prototype to pilot',
        'Publish applied research on sustainable technology solutions',
        'Expand your global network through city hubs and in-person events',
        'Graduate with an accredited German university degree',
      ],
      level: 'Advanced',
      rating: 4.8,
      totalStudents: 210,
      isFeatured: true,
      startDate: 'October 1, 2025',
      tags: ['AI Governance', 'Climate Tech', 'Master\'s', 'SDGs', 'Accredited'],
      programType: 'degree',
      degreeType: 'Master\'s',
      ects: 120,
      sdgGoals: [
        'SDG 7 – Clean Energy',
        'SDG 11 – Sustainable Cities',
        'SDG 13 – Climate Action',
        'SDG 17 – Partnerships',
      ],
    ),
    Program(
      id: 'prog_09',
      title: 'Impact MBA — Business for a Better World',
      category: 'Business',
      duration: '18 months',
      price: 18900,
      imageUrl: 'https://picsum.photos/seed/mba/800/500',
      description:
          'The world\'s first fully remote MBA designed around impact entrepreneurship and the '
          'UN Sustainable Development Goals. You will master modern business fundamentals while '
          'building, testing, and pitching a real impact venture. '
          '\n\nEach semester is structured as a series of real-world "challenges" — no lectures, '
          'no memorization. You will collaborate with peers from 50+ countries and present to '
          'actual investors, NGOs, and government partners throughout the program.',
      expertId: 'exp_08',
      outcomes: [
        'Lead and scale impact-driven organizations with clarity and confidence',
        'Apply financial modelling and investment analysis to social ventures',
        'Design circular and regenerative business models',
        'Build and pitch a fundable impact startup to real investors',
        'Navigate global governance, regulation, and ESG compliance',
        'Graduate with a state-recognized German MBA credential',
      ],
      level: 'Intermediate to Advanced',
      rating: 4.8,
      totalStudents: 280,
      isFeatured: true,
      startDate: 'November 1, 2025',
      tags: ['MBA', 'Impact', 'Entrepreneurship', 'ESG', 'Leadership'],
      programType: 'degree',
      degreeType: 'MBA',
      ects: 90,
      sdgGoals: [
        'SDG 8 – Decent Work & Economic Growth',
        'SDG 10 – Reduced Inequalities',
        'SDG 12 – Responsible Consumption',
        'SDG 17 – Partnerships',
      ],
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

  static List<Program> get courses =>
      programs.where((p) => p.isCourse).toList();

  static List<Program> get degrees =>
      programs.where((p) => p.isDegree).toList();
}
