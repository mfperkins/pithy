Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
if Rails.env == "production" || Rails.env == "development"
  Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
end
