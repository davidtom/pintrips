<h4>Add a photo (optional)</h4>
<%= fields_for :profile_image do |i| %>
  <p><%= i.label :url, "Image URL (please host elsewhere)"  %>
  <%= i.text_field :url %></p>
  <p><%= i.label :title %><br>
  <%= i.text_field :title %></p>
  <p><%= i.label :caption %><br>
  <%= i.text_area :caption %></p>
<% end %>
</div>s



<p>
  <%= f.label :profile_image_url %>:
  <%= f.text_field :profile_image_url %>
</p>
