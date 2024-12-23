## Main Features and Requirements

- This app will provide Organizations (starting with primary/elementary schools) an easy fundraising platform. A school administrator (Organization owner) will easily be able to upload a CSV of Participants after the succesful creation of a Campaign. The Participants will have a first_name, last_name, etc. They can also be tied to a Champion. There will be a unique code made upon the successful creation of CampaignParticipants. There will also be a QR code generated for ease of getting to the Particiapnts Calendar. Once a Calendar is fully purchased a new one can be created (ie. Calendar 2) as to not limit any possible fundraising. 

- We will use Stripe Connect for the Organizations to sign up. We can use [pay-rails/pay: Payments for Ruby on Rails apps](https://github.com/pay-rails/pay). 

- There should be some generic documentation available to the Orgnaziation to pass out. The idea is to make things as easy as possbile on the Organization. Documentation being things like flyers to pass out to participants and their guardians. 

- The fundraising happens by Donors purcashing a day on an arbitrary calendar (arbitrary in that it is not tied to an actual month. It is just 31 days). The Donor (who does not have to log in) can select multiple days to purchase at once. When the a day is selected by one Donor, use TurboStreams to automatically broadcast an update to any other possible Donor(s) viewing the same Calendar. The CalendarDay should have the status of “selected”. That status should last either for 4 minutes, the Donor that selected the day purchases it, or the Donor that selected it navigates away from the Calendar view. So, a CalendarDay can have the statues of “available”, “selected”, or “purchased”. 

- Once a day or days are purcahsed they should be updated in the Database and broadcasted to any current CalendarSessions to the associated Calendar. The Donor info should be updated (or created) via the Stripe webhook. Since the Donor will only fill out the form to purchase the days. We will be using the Stripe hosted checkout page. 

- We will need to track the purchase and it should have a relationship to the CalendarDay and Donor. The subsequent relations via the caledar day will be to the Campaign, CampaignParticipant, Champion, and Organization.

- An Organization will be able to have multiple Campaigns. The Champions will have a dashboard to see how their Participants are doing for a particular Campaign. 

- Organization admins will be able to see how a Campaign is going. 

- Users that can log in:
  - Org Admins
  - Org Champions

I want to use Devise. But also allow for Oauth via Google and Microsoft as most organizations I assume will already have emails via those providers. 

We will use [excid3/madmin: A robust Admin Interface for Ruby on Rails apps](https://github.com/excid3/madmin) for admin.   

Ask me any clarifying questions. 

---
## Secondary Features:
- Orgs can set the milestones on fundraising (ie prizes for certain amounts etc.) if the specific campaign has that offerring. 
- I want a way for Guardians to be able to receive emails about the Campaign they have a Participant in. Open to ideas on that.