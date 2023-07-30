function loadQuestionBasedOnType(id) {
    let type = $(`#survey_questions_${id}_question_types_id`).val();
    let questionAnswers = $(`#question_${id}_answers`);
    console.log(type);

    switch (type) {
        case "true_false":
        case "open_answer":
            questionAnswers.html("");
            break;
        case "closed_answer":
            $.ajax({
                url: `/questions/partial_closed/${id}`,
                type: "get",
                success: function (data) {
                    questionAnswers.html(data);
                }
            });
            break;
        default:
            throw "Invalid question type";
    }
}


export function deleteQuestion(id) {
    $(`#question_${id}`).html("").hide();
}
$('#add-question').on('ajax:beforeSend', function (event, xhr, settings) {
    let id = $("#questions").children("div").length;
    settings.url = `${settings.url}/${id}`
}).on('ajax:success', function (event, data, status, xhr) {
    $("#questions").append(data);
});


