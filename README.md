# Inviter
Take control of your rails app's invitation system using a set of model unique callbacks.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'inviter'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install inviter
```

Run the Installer:
```bash
rails g inviter:initializer install
```

Run new migrations:
```bash
rails db:migrate
```

## Usage
include the Inviterable module into your application controller
```ruby
class ApplicationRecord < ActiveRecord::Base
  include Inviterable
```
this gives you access to three 'acts_as' methods you can use to set up your invitation relations.
* acts_as_inviter
* acts_as_invitee
* acts_as_invited_to

place the acts_as_inviter method at the top of any model with the ability to send invitations
```ruby
class User < ApplicationRecord
  acts_as_inviter
```
like wise place the acts_as_invitee method wthin any model that can recieive invites. A model will frequently contain both 
acts_as_inviter and acts_as_invitee.
```ruby
class User < ApplicationRecord
  acts_as_inviter
  acts_as_invitee
```
all invitee models have access to **.invitations**  which returns an active record collection of all 
their invitee associated **Invitations**.
```ruby
invitee = User.first
invitee.invitations == Invitations.where(invitee: invitee)
```
Inviter models can also view there invitations using **.sent_invitations**
```ruby
inviter = User.first
inviter.sent_invitations == Invitations.where(inviter: inviter)
```

An inviter can use the **.send_invitation** method to create an invitation. The method takes a 
an invitee resource and invited_to model as arguments.
```ruby
inviter = User.first
invitee = User.second
invited_to = Party.first
inviter.send_invitation(invitee, invited_to)
```
place the acts_as_invited_to method in any model meant to show relation between an inviter and an invitee
```ruby
class Party < ApplicationRecord
  acts_as_invited_to
```
 Like an invitee, the invited_to model can access its associated invitations using **.invitations**
 ```ruby
 invited_to = Party.first
 invited_to.invitations == Invitations.where(invited_to: invited_to)
 ```
 ## The Invitation Model
The invitation model gives you options to manipulate created invitations.
 
 ```ruby
 accepted? # Returns true if accepted_at IS NOT NIL
 declined? # Returns true if declined_at IS NOT NIL
 accepted_or_declined? #Returns true if the invitation has been accepted or declined 
 accept #Accepts an invitation not already accepted or declined
 decline #Declines an invitation not already accepted or declined
 reset #Sets the declined_at and accepted_at timestamps to nil
 ```
 
 ## Callbacks
 When an valid action is done on an invitation, all invitee, inviter, and invited_to models are sent an associated _callback method for response.
 The valid actions are create, accept, declined and reset.
 To view the method name that each action will create use the 
 **Inviter::InvitationCallbacks** module.
 The Inviter::InvitationCallbacks module contains a callback generator for each available valid action.
  ```ruby
  Inviter::InvitationCallbacks.invitation_created_callback
  Inviter::InvitationCallbacks.invitation_accepted_callback
  Inviter::InvitationCallbacks.invitation_declined_callback
  Inviter::InvitationCallbacks.invitation_reset_callback
  ```
These methods take an inviter, invitee, and invited_to instance class as arguments and return a method name string.
For example:
```ruby
args = [User.first, User.second, Party.first]
Inviter::InvitationCallbacks.invitation_created_callback(*args) 
    #=> 'user_invited_user_to_party'
Inviter::InvitationCallbacks.invitation_accepted_callback(*args)
    #=> 'user_accepted_invite_from_user_to_party'
Inviter::InvitationCallbacks.invitation_declined_callback(*args) 
    #=> 'user_declined_invite_from_user_to_party'
Inviter::InvitationCallbacks.invitation_reset_callback
    #=> 'user_reset_invite_from_user_to_party
```

# Example Models

```ruby
class Party < ApplicationRecord
  acts_as_invited_to

  has_many :user_parties
  has_many :users, through: :user_parties
end
```

```ruby
class UserParty < ApplicationRecord
  belongs_to :user
  belongs_to :party
end
```
```ruby
class User < ApplicationRecord
  acts_as_inviter
  acts_as_invitee

  has_many :user_parties
  has_many :parties, through: :user_parties

  private

  class << self
    def user_invited_user_to_party(invitation)
      # Do Something when user invites user to party
      UserMailer.invitatation_sent_email
    end

    def user_accepted_invite_from_user_to_party(invitation)
      # Add user to party users collection
      invitation.invited_to.users << invitation.invitee
    end

    def user_declined_invite_from_user_to_party(invitation)
      # Do Something when user declined invite from user to party
      UserMailer.invitation_declined_email
    end

    def user_reset_invite_from_user_to_party(invitation)
      # Do Something when user resets invite from user to party
      UserMailer.invitation_reset_email
    end
  end
end
```

These same methods would also be executed on the Party Model if they existed.
Each callback method also brings its associated invitation through the invitations variable.

## Contributing
TBA

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
