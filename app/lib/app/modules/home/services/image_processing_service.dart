import 'interfaces/ihttp_service.dart';
import 'interfaces/iimage_processing_service.dart';

class ImageProcessingService implements IImageProcessingService {
  final IHttpService _httpService;

  ImageProcessingService(this._httpService);


  @override
  Future<Map<String, dynamic>> toGrayscale(String image, String id) async {
    final result = await _httpService.post(
      endpoint: 'gray_scale',
      data: {
        'id': id,
        'image': image,
      },
    );

    return {
      'id': result['id'],
      'image': result['image'],
    };
  }


  @override
  Future<Map<String, dynamic>> toBlur(String image, String id) async {
    final result = await _httpService.post(
      endpoint: 'blur',
      data: {
        'id': id,
        'image': image,
      },
    );

    return {
      'id': result['id'],
      'image': result['image'],
    };
  }

  @override
  Future<Map<String, dynamic>> toContrast(String image, String id) async {
    final result = await _httpService.post(
      endpoint: 'contrast',
      data: {
        'id': id,
        'image': image,
      },
    );

    return {
      'id': result['id'],
      'image': result['image'],
    };
  }

  @override
  Future<Map<String, dynamic>> toDetail(String image, String id) async {
    final result = await _httpService.post(
      endpoint: 'detail',
      data: {
        'id': id,
        'image': image,
      },
    );

    return {
      'id': result['id'],
      'image': result['image'],
    };
  }
  
  @override
  Future<Map<String, dynamic>> toEmboss(String image, String id) async {
    final result = await _httpService.post(
      endpoint: 'emboss',
      data: {
        'id': id,
        'image': image,
      },
    );

    return {
      'id': result['id'],
      'image': result['image'],
    };
  }

  @override
  Future<Map<String, dynamic>> toSobel(String image, String id) async {
    final result = await _httpService.post(
      endpoint: 'sobel',
      data: {
        'id': id,
        'image': image,
      },
    );

    return {
      'id': result['id'],
      'image': result['image'],
    };
  }

  @override
  Future<Map<String, dynamic>> toContour(String image, String id) async {
    final result = await _httpService.post(
      endpoint: 'contour',
      data: {
        'id': id,
        'image': image,
      },
    );

    return {
      'id': result['id'],
      'image': result['image'],
    };
  }

  @override
  Future<Map<String, dynamic>> getColorHistogram(String image, String id) async {
    final result = await _httpService.post(
      endpoint: 'histogram',
      data: {
        'id': id,
        'image': image,
      },
    );

    return {
      'id': result['id'],
      'image': result['image'],
    };
  }
}
