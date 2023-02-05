import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:root_master/screens/result/result_screen.dart';

import '../di/injector.dart';
import '../dto/question_dto.dart';
import '../service/room_service.dart';

class QuestionController extends GetxController with GetSingleTickerProviderStateMixin {
  final BuildContext context;

  QuestionController(this.context);

  final RoomService _roomService = injector<RoomService>();

  late AnimationController _animationController;
  late Animation _animation;

  Animation get animation => _animation;

  late PageController _pageController;

  PageController get pageController => _pageController;

  late List<QuestionDto> _questions;

  List<QuestionDto> get questions => _questions;

  bool _isAnswered = false;

  bool get isAnswered => _isAnswered;

  late int _correctAns;

  int get correctAns => _correctAns;

  late int _selectedAns;

  int get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => _numOfCorrectAns;

  @override
  void onInit() {
    _questions = _roomService.getQuestions();
    _animationController = AnimationController(duration: const Duration(seconds: 60), vsync: this);

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    _animationController.forward().whenComplete(notAnswered);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(QuestionDto question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answerIndex;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    _animationController.stop();

    update();

    Future.delayed(const Duration(seconds: 2), () {
      _roomService.answer(question.id, selectedIndex, ((1 - _animationController.value) * 100).toInt());
      if (_questionNumber.value == _questions.length) {
        // _pageController.dispose();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ResultScreen()), (e) => false);
      } else {
        _roomService.getShowModal(context, nextQuestion);
      }
    });
  }

  void notAnswered() {
    _roomService.answer(_roomService.getQuestionId(_questionNumber.value), -1, 0);
    if (_questionNumber.value == _questions.length) {
      // _pageController.dispose();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ResultScreen()), (e) => false);
    } else {
      _roomService.getShowModal(context, nextQuestion);
    }
  }

  void nextQuestion() {
    Navigator.pop(context);
    _roomService.setPlayerPreparing();
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.ease);

      _animationController.reset();

      _animationController.forward().whenComplete(notAnswered);
    } else {
      // _pageController.dispose();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ResultScreen()), (e) => false);
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
