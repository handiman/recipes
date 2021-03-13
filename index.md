---
---
<ul>{% for recipe in site.recipes %}
  <li><a href="{{ recipe.id }}">{{ recipe.title }}</a></li>
{% endfor %}</ul>