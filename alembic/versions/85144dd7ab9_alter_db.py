"""alter db

Revision ID: 85144dd7ab9
Revises: 1d805dddc88
Create Date: 2014-10-04 21:35:23.508455

"""

# revision identifiers, used by Alembic.
revision = '85144dd7ab9'
down_revision = '1d805dddc88'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.create_table('posting',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('account_from_id', sa.Integer(), nullable=True),
    sa.Column('account_to_id', sa.Integer(), nullable=True),
    sa.Column('account_item_id', sa.Integer(), nullable=False),
    sa.Column('sum', sa.Numeric(precision=16, scale=2), nullable=False),
    sa.Column('date', sa.Date(), nullable=False),
    sa.CheckConstraint('account_from_id is not null or account_to_id is not null', name='constraint_at_list_single_account_not_null'),
    sa.ForeignKeyConstraint(['account_from_id'], ['account.id'], name='fk_account_from_id_posting', onupdate='cascade', ondelete='restrict'),
    sa.ForeignKeyConstraint(['account_item_id'], ['account_item.id'], name='fk_account_item_id_posting', onupdate='cascade', ondelete='restrict'),
    sa.ForeignKeyConstraint(['account_to_id'], ['account.id'], name='fk_account_to_id_posting', onupdate='cascade', ondelete='restrict'),
    sa.PrimaryKeyConstraint('id')
    )
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('posting')
    ### end Alembic commands ###