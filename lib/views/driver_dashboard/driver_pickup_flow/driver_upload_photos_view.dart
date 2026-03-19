import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../export_all.dart';

import 'driver_pickup_flow_shared_widgets.dart';

class DriverUploadPhotosView extends StatefulWidget {
  const DriverUploadPhotosView({
    super.key,
    required this.data,
    required this.arrivalTime,
    required this.collectedLiters,
  });

  final DriverPickupRequestData data;
  final String arrivalTime;
  final double collectedLiters;

  @override
  State<DriverUploadPhotosView> createState() => _DriverUploadPhotosViewState();
}

class _DriverUploadPhotosViewState extends State<DriverUploadPhotosView> {
  static const int _maxPhotos = 12;

  final ImagePicker _picker = ImagePicker();
  final List<XFile> _photos = [];

  Future<void> _pickImage(ImageSource source) async {
    if (_photos.length >= _maxPhotos) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can add up to $_maxPhotos photos.')),
      );
      return;
    }
    final XFile? file = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );
    if (file == null || !mounted) return;
    setState(() => _photos.add(file));
  }

  void _showPickSourceSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Take photo'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _removePhoto(int index) {
    setState(() => _photos.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.20;

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: const DriverFlowBottomNavBar(currentIndex: 1),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: '',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 180,
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  8,
                  horizontalPadding,
                  120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Upload Photos',
                      style: context.robotoFlexBold(fontSize: 26, color: Colors.black),
                    ),
                    8.ph,
                    Text(
                      'Please upload proof of collected quantity',
                      style: context.robotoFlexRegular(
                        fontSize: 14,
                        color: Colors.black.withValues(alpha: 0.7),
                      ),
                    ),
                    18.ph,
                    _PhotosGrid(
                      photos: _photos,
                      maxPhotos: _maxPhotos,
                      onAdd: _showPickSourceSheet,
                      onRemove: _removePhoto,
                    ),
                    24.ph,
                    CustomButtonWidget(
                      label: 'Continue',
                      onPressed: () {
                        AppRouter.push(
                          DriverPickupCompletedView(
                            data: widget.data,
                            arrivalTime: widget.arrivalTime,
                            collectedLiters: widget.collectedLiters,
                          ),
                        );
                      },
                      height: 58,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.paddingOf(context).top + 8,
              left: 12,
              child: GestureDetector(
                onTap: () => AppRouter.back(),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotosGrid extends StatelessWidget {
  const _PhotosGrid({
    required this.photos,
    required this.maxPhotos,
    required this.onAdd,
    required this.onRemove,
  });

  final List<XFile> photos;
  final int maxPhotos;
  final VoidCallback onAdd;
  final void Function(int index) onRemove;

  @override
  Widget build(BuildContext context) {
    const crossAxisCount = 3;
    final showAddTile = photos.length < maxPhotos;
    final itemCount = photos.length + (showAddTile ? 1 : 0);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final isAddTile = showAddTile && index == photos.length;

        if (isAddTile) {
          return InkWell(
            onTap: onAdd,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Icon(Icons.add, size: 30, color: AppColors.primaryColor),
              ),
            ),
          );
        }

        final path = photos[index].path;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(File(path), fit: BoxFit.cover),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Material(
                    color: Colors.black.withValues(alpha: 0.55),
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => onRemove(index),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.close, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
