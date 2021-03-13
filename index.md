---
---
<ul>{% for recipe in site.recipes %}
  <li><a href="{{ recipe.id | absolute_url }}">{{ recipe.title }}</a></li>
{% endfor %}</ul>