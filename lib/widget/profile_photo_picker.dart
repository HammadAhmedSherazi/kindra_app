import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../export_all.dart';

class ProfilePhotoPicker extends StatefulWidget {
  const ProfilePhotoPicker({
    super.key,
    required this.onChanged,
    this.localImage,
    this.networkImageUrl,
    this.enabled = true,
  });

  final XFile? localImage;
  final String? networkImageUrl;
  final bool enabled;
  final ValueChanged<XFile?> onChanged;

  @override
  State<ProfilePhotoPicker> createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFromGallery() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (!mounted) return;
      if (file == null) return;
      widget.onChanged(file);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open gallery.')),
      );
    }
  }

  Future<void> _captureFromCamera() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (!mounted) return;
      if (file == null) return;
      widget.onChanged(file);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open camera.')),
      );
    }
  }

  void _remove() => widget.onChanged(null);

  ImageProvider _imageProvider() {
    final local = widget.localImage;
    if (local != null) return FileImage(File(local.path));

    final url = widget.networkImageUrl?.trim() ?? '';
    if (url.isNotEmpty) return NetworkImage(url);

    return const AssetImage(Assets.userAvatar);
  }

  Future<void> _showPickerSheet() async {
    if (!widget.enabled) return;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final hasLocal = widget.localImage != null;
        final hasRemote = (widget.networkImageUrl?.trim().isNotEmpty ?? false);
        final canRemove = hasLocal || hasRemote;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 8, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Choose from gallery'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _pickFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera_outlined),
                  title: const Text('Take a photo'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _captureFromCamera();
                  },
                ),
                if (canRemove)
                  ListTile(
                    leading: Icon(
                      Icons.delete_outline,
                      color: Colors.red.withValues(alpha: 0.85),
                    ),
                    title: Text(
                      'Remove photo',
                      style: TextStyle(
                        color: Colors.red.withValues(alpha: 0.85),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      _remove();
                    },
                  ),
                12.ph,
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.06),
                image: DecorationImage(
                  image: _imageProvider(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                elevation: 2,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _showPickerSheet,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 20,
                      color: widget.enabled
                          ? Colors.black.withValues(alpha: 0.75)
                          : Colors.black.withValues(alpha: 0.35),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

