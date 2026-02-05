import '../export_all.dart';

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget({
    super.key,
    required this.news,
    this.onTap,
  });

  final NewsModel news;
  final VoidCallback? onTap;

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

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: SizedBox(
        height: 114,
        child: Row(
        spacing: 10,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Image.network(
              imageUrl,
              height: double.infinity,
              width: 114,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: double.infinity,
                width: 114,
                color: Colors.grey.shade300,
                child: Icon(Icons.image_not_supported),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.66),
                    fontSize: 14,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w300,
                    height: 1.37,
                  ),
                ),
                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Colors.black.withValues(alpha: 0.40),
                      size: 18,
                    ),
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
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
}
