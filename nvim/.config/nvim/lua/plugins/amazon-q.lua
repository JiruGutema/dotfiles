return {
  {
    name = 'amazonq',
    url = 'https://github.com/awslabs/amazonq.nvim.git',
    opts = {
      -- Authenticate with Amazon Q Free Tier using AWS Builder ID
      ssoStartUrl = 'https://view.awsapps.com/start', 
      -- If you have a Pro subscription, swap this with your organization's URL:
      -- ssoStartUrl = 'your-organization-sso-url',
    },
  },
}
