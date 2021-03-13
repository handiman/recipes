---
---
<ul>{% for recipe in site.recipes %}
  <li><a href="{{ recipe.url | absolute_url }}">{{ recipe.title }}</a></li>
{% endfor %}</ul>