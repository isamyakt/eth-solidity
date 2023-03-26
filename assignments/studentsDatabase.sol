// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract ScoreCard {

    address public classTeacher;
    uint studentCount = 0;
    uint studentCountMarks = 0;

    struct Student {
        string firstName;
        string lastName;
        uint id;
    }

    struct Score {
        uint id;
        uint mathScore;
        uint scienceScore;
        uint englishScore;
    }

    constructor() {
        classTeacher = msg.sender;
    }

    mapping(uint => Student) public students;
    mapping(uint => Score) public scores;

    event StudentAdded(string _firstName, string _lastName, uint _id);
    event ScoreAdded(uint _mathScore, uint _scienceScore, uint _englishScore, uint _id);

    modifier onlyClassTeacher(address _classTeacher) {
        require(classTeacher == _classTeacher, "Only Class Teacher can add student details!");
        _;
    }

    function addStudentDetails(string memory _firstName, string memory _lastName) public onlyClassTeacher(msg.sender) {
        Student storage studentObj = students[studentCount];
        studentObj.firstName = _firstName;
        studentObj.lastName = _lastName;
        studentObj.id = studentCount;

        emit StudentAdded(_firstName, _lastName, studentCount);
        studentCount++;

    }

    function addStudentMarks(uint _mathScore, uint _scienceScore, uint _englishScore) public onlyClassTeacher(msg.sender) {
        Score storage scoreObj = scores[studentCountMarks];
        scoreObj.mathScore = _mathScore;
        scoreObj.scienceScore = _scienceScore;
        scoreObj.englishScore = _englishScore;

        emit ScoreAdded(_mathScore, _scienceScore, _englishScore, studentCountMarks);
        studentCountMarks++;
    }

    // function getScores(uint _id) public view returns (Score memory) {
    //     return scores[_id];
    // }

    // function getStudent(uint _id) public view returns (Student memory) {
    //     return students[_id];
    // }

}