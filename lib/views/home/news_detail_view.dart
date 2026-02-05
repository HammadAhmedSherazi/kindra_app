import '../../export_all.dart';

class NewsDetailView extends StatelessWidget {
  const NewsDetailView({
    super.key,
    required this.news,
  });

  final NewsModel news;

  static const List<String> _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day} ${_monthNames[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = news.image ??
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8kvhwsPdeSIGSEvbktsxc_4pQpEqu4ykg4A&s';
    final title = news.title ?? '';
    final description = news.description ?? '';
    final dateStr = _formatDate(news.date);

    final shareButton = IconButton(
      onPressed: () {
        // TODO: Share action
      },
      icon: Container(
        width: 40,
        height: 40,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: OvalBorder(
            side: BorderSide(width: 1, color: const Color(0xFFC9C9C9)),
          ),
        ),
        child: Icon(Icons.share, size: 20),
      ),
    );

    return CustomInnerScreenTemplate(
      title: 'News Detail',
      actionButton: shareButton,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.image_not_supported, size: 48),
                ),
              ),
            ),
            16.ph,
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            12.ph,
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: Colors.black.withValues(alpha: 0.40),
                  size: 18,
                ),
                6.pw,
                Text(
                  dateStr,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.40),
                    fontSize: 14,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w300,
                    height: 1.14,
                  ),
                ),
              ],
            ),
            16.ph,
            Text(
              description,
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.66),
                fontSize: 15,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
