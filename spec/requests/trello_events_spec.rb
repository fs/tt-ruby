require 'spec_helper'

describe '/trello_events' do

  describe 'create' do
    let(:data) do
      {
        "action" => {
          "id" => "51f9424bcd6e040f3c002412",
          "idMemberCreator" => "4fc78a59a885233f4b349bd9",
          "data" => {
            "board" => {
              "name" =>"Trello Development",
              "id" => "4d5ea62fd76aa1136000000c"
            },
            "card" => {
              "idShort" => 1458,
              "name" => "Webhooks",
              "id" => "51a79e72dbb7e23c7c003778"
            },
            "voted" => true
          },
          "type" => "voteOnCard",
          "date" => "2013-07-31T16=>58=>51.949Z",
          "memberCreator" => {
            "id" => "4fc78a59a885233f4b349bd9",
            "avatarHash" => "2da34d23b5f1ac1a20e2a01157bfa9fe",
            "fullName" => "Doug Patti",
            "initials" => "DP",
            "username" => "doug"
          }
        },
        "model" => {
          "id" => "4d5ea62fd76aa1136000000c",
          "name" => "Trello Development",
          "desc" => "Trello board used by the Trello team to track work on Trello.  How meta!\n\nThe development of the Trello API is being tracked at https://trello.com/api\n\nThe development of Trello Mobile applications is being tracked at https://trello.com/mobile",
          "closed" => false,
          "idOrganization" => "4e1452614e4b8698470000e0",
          "pinned" => true,
          "url" => "https://trello.com/b/nC8QJJoZ/trello-development",
          "prefs" => {
            "permissionLevel" => "public",
            "voting" => "public",
            "comments" => "public",
            "invitations" => "members",
            "selfJoin" => false,
            "cardCovers" => true,
            "canBePublic" => false,
            "canBeOrg" => false,
            "canBePrivate" => false,
            "canInvite" => true
          },
          "labelNames" => {
            "yellow" => "Infrastructure",
            "red" => "Bug",
            "purple" => "Repro'd",
            "orange" => "Feature",
            "green" => "Mobile",
            "blue" => "Verified"
          }
        }
      }
    end

    def callback_request
      post('/trello_events', data)
    end

    it 'creates new empty submission' do
      expect{callback_request}.to change{Submission.count}.by(1)
    end
  end
end