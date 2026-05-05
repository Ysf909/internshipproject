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
      imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
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
      imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
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
      imageUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
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
      imageUrl: 'https://randomuser.me/api/portraits/men/75.jpg',
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
      imageUrl: 'https://randomuser.me/api/portraits/women/55.jpg',
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
      imageUrl: 'https://randomuser.me/api/portraits/men/62.jpg',
      rating: 4.9,
      totalStudents: 1100,
      programIds: ['prog_06'],
      linkedIn: 'https://linkedin.com/in/omarfarouq',
    ),
  ];

  // ── Programs ─────────────────────────────────────────────
  static final List<Program> programs = [
    Program(
      id: 'prog_01',
      title: 'Data Science & Machine Learning',
      category: 'Technology',
      duration: '12 weeks',
      price: 1299,
      imageUrl:
          'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=500&fit=crop',
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
    ),
    Program(
      id: 'prog_02',
      title: 'Flutter Mobile Development',
      category: 'Technology',
      duration: '10 weeks',
      price: 999,
      imageUrl:
          'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800&h=500&fit=crop',
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
    ),
    Program(
      id: 'prog_03',
      title: 'Product Management Fundamentals',
      category: 'Business',
      duration: '8 weeks',
      price: 799,
      imageUrl:
          'https://images.unsplash.com/photo-1552664730-d307ca884978?w=800&h=500&fit=crop',
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
    ),
    Program(
      id: 'prog_04',
      title: 'UX/UI Design Masterclass',
      category: 'Design',
      duration: '10 weeks',
      price: 899,
      imageUrl:
          'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800&h=500&fit=crop',
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
    ),
    Program(
      id: 'prog_05',
      title: 'Digital Marketing Strategy',
      category: 'Marketing',
      duration: '6 weeks',
      price: 599,
      imageUrl:
          'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=500&fit=crop',
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
    ),
    Program(
      id: 'prog_06',
      title: 'Full-Stack Web Development',
      category: 'Technology',
      duration: '16 weeks',
      price: 1499,
      imageUrl:
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800&h=500&fit=crop',
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
