---
---
<ul>{% for recipe in site.recipes %}
  <li><a href="{{ recipe.url }}.html">{{ recipe.title }}</a></li>
{% endfor %}</ul>