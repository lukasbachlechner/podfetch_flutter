import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class PodfetchStaticCategoriesRepository {
  final List<StaticCategory> _allCategories = const [
    StaticCategory(
      id: 1,
      title: 'Arts',
      iconData: BootstrapIcons.palette_fill,
      children: [
        StaticCategory(id: 3, title: "Design"),
        StaticCategory(id: 4, title: "Fashion & Beauty"),
        StaticCategory(id: 6, title: "Food"),
        StaticCategory(id: 7, title: "Performing Arts"),
        StaticCategory(id: 8, title: "Visual Arts"),
      ],
    ),
    StaticCategory(
      id: 9,
      title: 'Business',
      iconData: BootstrapIcons.briefcase_fill,
      children: [
        StaticCategory(id: 10, title: "Careers"),
        StaticCategory(id: 11, title: "Entrepreneurship"),
        StaticCategory(id: 12, title: "Investing"),
        StaticCategory(id: 13, title: "Management"),
        StaticCategory(id: 14, title: "Marketing"),
        StaticCategory(id: 15, title: "Non-Profit"),
      ],
    ),
    StaticCategory(
      id: 16,
      title: 'Comedy',
      iconData: BootstrapIcons.emoji_smile_fill,
      children: [
        StaticCategory(id: 17, title: 'Comedy Interviews'),
        StaticCategory(id: 18, title: 'Improv'),
        StaticCategory(id: 19, title: 'Stand-Up'),
      ],
    ),
    StaticCategory(
        id: 20,
        title: 'Education',
        iconData: BootstrapIcons.mortarboard_fill,
        children: [
          StaticCategory(id: 21, title: 'Courses'),
          StaticCategory(id: 22, title: 'How-To'),
          StaticCategory(id: 23, title: 'Language Learning'),
          StaticCategory(id: 25, title: 'Self-Improvement'),
        ]),
    StaticCategory(id: 58, title: 'Government', iconData: BootstrapIcons.bank),
    StaticCategory(
        id: 28, title: 'History', iconData: BootstrapIcons.hourglass_split),
    StaticCategory(
      id: 29,
      title: 'Health & Fitness',
      iconData: BootstrapIcons.activity,
      children: [
        StaticCategory(id: 31, title: 'Alternative Health'),
        StaticCategory(id: 30, title: 'Fitness'),
        StaticCategory(id: 32, title: 'Medicine'),
        StaticCategory(id: 33, title: 'Mental Health'),
        StaticCategory(id: 34, title: 'Nutrition'),
        StaticCategory(id: 35, title: 'Sexuality'),
      ],
    ),
    StaticCategory(
        id: 36,
        title: 'Kids & Family',
        iconData: BootstrapIcons.people_fill,
        children: [
          StaticCategory(id: 38, title: 'Parenting'),
          StaticCategory(id: 39, title: 'Pets & Animals'),
          StaticCategory(id: 41, title: 'Stories for Kids'),
        ]),
    StaticCategory(
        id: 42,
        title: 'Leisure',
        iconData: BootstrapIcons.bicycle,
        children: [
          StaticCategory(id: 42, title: 'Animation & Manga'),
          StaticCategory(id: 45, title: 'Automotive'),
          StaticCategory(id: 46, title: 'Aviation'),
          StaticCategory(id: 47, title: 'Crafts'),
          StaticCategory(id: 48, title: 'Games'),
          StaticCategory(id: 49, title: 'Hobbies'),
          StaticCategory(id: 50, title: 'Home & Garden'),
          StaticCategory(id: 52, title: 'Video Games'),
        ]),
    StaticCategory(
        id: 53, title: 'Music', iconData: BootstrapIcons.music_note_beamed),
    StaticCategory(
        id: 55,
        title: 'News',
        iconData: BootstrapIcons.newspaper,
        children: [
          StaticCategory(id: 56, title: 'Daily News'),
          StaticCategory(id: 57, title: 'Entertainment News'),
          StaticCategory(id: 59, title: 'Politics'),
        ]),
    StaticCategory(
        id: 65,
        title: 'Religion',
        iconData: BootstrapIcons.flower1,
        children: [
          StaticCategory(id: 60, title: 'Buddhism'),
          StaticCategory(id: 61, title: 'Christianity'),
          StaticCategory(id: 62, title: 'Hinduism'),
          StaticCategory(id: 63, title: 'Islam'),
          StaticCategory(id: 64, title: 'Judaism'),
          StaticCategory(id: 66, title: 'Spirituality'),
        ]),
    StaticCategory(
        id: 67,
        title: 'Science',
        iconData: BootstrapIcons.clipboard,
        children: [
          StaticCategory(id: 64, title: 'Astronomy'),
          StaticCategory(id: 64, title: 'Chemistry'),
          StaticCategory(id: 64, title: 'Earth Sciences'),
          StaticCategory(id: 64, title: 'Life Sciences'),
          StaticCategory(id: 64, title: 'Mathematics'),
          StaticCategory(id: 64, title: 'Natural Sciences'),
          StaticCategory(id: 64, title: 'Nature'),
          StaticCategory(id: 64, title: 'Physics'),
        ]),
    StaticCategory(
        id: 77,
        title: 'Society & Culture',
        iconData: BootstrapIcons.globe2,
        children: [
          StaticCategory(id: 79, title: 'Documentary'),
          StaticCategory(id: 80, title: 'Personal Journals'),
          StaticCategory(id: 82, title: 'Philosophy'),
          StaticCategory(id: 83, title: 'Places & Travel'),
          StaticCategory(id: 85, title: 'Relationships'),
        ]),
    StaticCategory(
        id: 86,
        title: 'Sports',
        iconData: BootstrapIcons.trophy_fill,
        children: [
          StaticCategory(id: 87, title: 'Baseball'),
          StaticCategory(id: 88, title: 'Basketball'),
          StaticCategory(id: 89, title: 'Cricket'),
          StaticCategory(id: 90, title: 'Fantasy'),
          StaticCategory(id: 91, title: 'Football'),
          StaticCategory(id: 92, title: 'Golf'),
          StaticCategory(id: 93, title: 'Hockey'),
          StaticCategory(id: 94, title: 'Rugby'),
          StaticCategory(id: 95, title: 'Running'),
          StaticCategory(id: 96, title: 'Soccer'),
          StaticCategory(id: 97, title: 'Swimming'),
          StaticCategory(id: 98, title: 'Tennis'),
          StaticCategory(id: 99, title: 'Volleyball'),
          StaticCategory(id: 100, title: 'Wilderness'),
          StaticCategory(id: 101, title: 'Wrestling'),
        ]),
    StaticCategory(
        id: 102, title: 'Technology', iconData: BootstrapIcons.cpu_fill),
    StaticCategory(
        id: 103, title: 'True Crime', iconData: BootstrapIcons.fingerprint),
    StaticCategory(
        id: 104,
        title: 'TV & Film',
        iconData: BootstrapIcons.tv_fill,
        children: [
          StaticCategory(id: 106, title: 'After Shows'),
          StaticCategory(id: 107, title: 'Film Reviews'),
        ]),
  ];

  List<StaticCategory> getAll() {
    return _allCategories;
  }

  List<StaticCategory> getAllFlat() {
    final List<StaticCategory> result = [];
    for (var category in _allCategories) {
      result.add(category);
      if (category.children != null && category.children!.isNotEmpty) {
        result.addAll(category.children!.toList());
      }
    }
    return result;
  }

  List<StaticCategory?> getAllByIds(List<int> ids) {
    final allCategories = getAllFlat();
    return allCategories
        .where((category) => ids.contains(category.id))
        .toList();
  }
}

class StaticCategory {
  final int id;
  final String title;
  final IconData? iconData;

  final List<StaticCategory>? children;

  const StaticCategory({
    required this.id,
    required this.title,
    this.children,
    this.iconData,
  });
}
