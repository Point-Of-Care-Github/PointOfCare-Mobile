import 'package:flutter/material.dart';

import './diseaseLabel.dart';

class DiseaseLabels with ChangeNotifier {
  final List<DiseaseLabel> _labels = [
    DiseaseLabel(
      id: 'l1',
      name: 'Atelectasis',
      percentage: '93.56%',
      likeness: 'Very Likely',
    ),
    DiseaseLabel(
      id: 'l2',
      name: 'Cardiomegaly',
      percentage: '73.56%',
      likeness: 'Likely',
    ),
    DiseaseLabel(
      id: 'l3',
      name: 'Effusion',
      percentage: '50.56%',
      likeness: 'Likely',
    ),
    DiseaseLabel(
      id: 'l4',
      name: 'Infiltration',
      percentage: '12.56%',
      likeness: 'Very UnLikely',
    ),
    DiseaseLabel(
      id: 'l5',
      name: ' Mass',
      percentage: '0.002%',
      likeness: 'Very UnLikely',
    ),
    DiseaseLabel(
      id: 'l6',
      name: 'Nodule',
      percentage: '0%',
      likeness: 'Very UnLikely',
    ),
    DiseaseLabel(
      id: 'l7',
      name: 'Pneumonia',
      percentage: '0%',
      likeness: 'Very UnLikely',
    ),
    DiseaseLabel(
      id: 'l8',
      name: 'Pneumothorax',
      percentage: '0%',
      likeness: 'Very UnLikely',
    ),
    DiseaseLabel(
      id: 'l9',
      name: 'Consolidation',
      percentage: '0%',
      likeness: 'Very UnLikely',
    ),
    DiseaseLabel(
      id: 'l10',
      name: 'Edema',
      percentage: '0%',
      likeness: 'Very UnLikely',
    ),
    DiseaseLabel(
      id: 'l11',
      name: 'Emphysema',
      percentage: '0%',
      likeness: 'Very UnLikely',
    ),
    DiseaseLabel(
      id: 'l12',
      name: 'Fibrosis',
      percentage: '0%',
      likeness: 'Very UnLikely',
    ),
    DiseaseLabel(
      id: 'l13',
      name: 'Pleural Thickening',
      percentage: '0%',
      likeness: 'Very UnLikely',
    ),
    DiseaseLabel(
      id: 'l14',
      name: 'Hernia',
      percentage: '0%',
      likeness: 'Very UnLikely',
    ),
  ];
  List<DiseaseLabel> get labels {
    return [..._labels];
  }

  DiseaseLabel findById(String id) {
    return _labels.firstWhere((label) => label.id == id);
  }
}
