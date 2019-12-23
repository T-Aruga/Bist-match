$(function() {
    $('[data-channel-subscribe="conversation"]').each(function(index, element) {
        var $element = $(element),
            $chatList = $('#message_list'),
            $form = $('#new_message'),

            conversation_id = $element.data('conversation-id'),
            user_id = $element.data('user-id')

            App.cable.subscriptions.create(
            {
                channel: "MessagesChannel",
                conversation: conversation_id
            },
            {
                received: function(data) {
                    if (data.sender_id == user_id) {
                        $chatList.append(data.sender)
                    } else {
                        $chatList.append(data.receipient)
                    }

                    $form[0].reset();
                    $chatList.animate({ scrollTop: $chatList.prop("scrollHeight") }, 1000)
                }
            }
        )
    });
});
